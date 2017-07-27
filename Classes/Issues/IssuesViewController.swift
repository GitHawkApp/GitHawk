//
//  IssuesViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import TUSafariActivity
import SafariServices
import SlackTextViewController

final class IssuesViewController: SLKTextViewController,
    ListAdapterDataSource,
    FeedDelegate,
    AddCommentListener,
    IssueCommentAutocompleteDelegate,
FeedSelectionProviding {

    private let client: GithubClient
    private let owner: String
    private let repo: String
    private let number: Int

    private var addCommentClient: AddCommentClient? = nil {
        didSet {
            self.setTextInputbarHidden(addCommentClient == nil, animated: true)
        }
    }

    private let autocomplete = IssueCommentAutocomplete(autocompletes: [EmojiAutocomplete()])
    private var models = [ListDiffable]()
    lazy private var feed: Feed = { Feed(viewController: self, delegate: self, collectionView: self.collectionView, managesLayout: false) }()

    init(
        client: GithubClient,
        owner: String,
        repo: String,
        number: Int
        ) {
        self.client = client
        self.owner = owner
        self.repo = repo
        self.number = number

        // force unwrap, this absolutely must work
        super.init(collectionViewLayout: UICollectionViewFlowLayout())!

        title = "\(owner)/\(repo)#\(number)"

        // not registered until request is finished and self.registerPrefixes(...) is called
        // must have user autocompletes
        autocomplete.configure(tableView: autoCompletionView, delegate: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        feed.viewDidLoad()
        feed.adapter.dataSource = self

        // override default SLKTextViewController values
        isInverted = false
        textView.placeholder = NSLocalizedString("Leave a comment", comment: "")
        textView.keyboardType = .default
        rightButton.setTitle(NSLocalizedString("Send", comment: ""), for: .normal)
        rightButton.setTitleColor(Styles.Colors.Blue.medium.color, for: .normal)

        // displayed once an add comment client is created (requires a gql subject id)
        setTextInputbarHidden(true, animated: false)

        let rightItem = UIBarButtonItem(
            image: UIImage(named: "bullets-hollow"),
            style: .plain,
            target: self,
            action: #selector(IssuesViewController.onMore(sender:))
        )
        rightItem.accessibilityLabel = NSLocalizedString("More options", comment: "")
        navigationItem.rightBarButtonItem = rightItem
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        feed.viewWillLayoutSubviews(view: view)
    }

    // MARK: SLKTextViewController overrides

    override func keyForTextCaching() -> String? {
        return "issue.\(owner).\(repo).\(number)"
    }

    override func canPressRightButton() -> Bool {
        return addCommentClient != nil && super.canPressRightButton()
    }

    override func didPressRightButton(_ sender: Any?) {
        // get text before calling super b/c it will clear it
        let text = textView.text

        super.didPressRightButton(sender)
        guard let addCommentClient = self.addCommentClient else { return }

        if let text = text {
            addCommentClient.addComment(body: text)
        }
    }

    override func didChangeAutoCompletionPrefix(_ prefix: String, andWord word: String) {
        autocomplete.didChange(tableView: autoCompletionView, prefix: prefix, word: word)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autocomplete.resultCount(prefix: foundPrefix)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return autocomplete.cell(tableView: tableView, prefix: foundPrefix, indexPath: indexPath)
    }

    override func heightForAutoCompletionView() -> CGFloat {
        return autocomplete.resultHeight(prefix: foundPrefix)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let accept = autocomplete.accept(prefix: foundPrefix, indexPath: indexPath) {
            acceptAutoCompletion(with: accept, keepPrefix: false)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return autocomplete.cellHeight
    }

    override func shouldDisableTypingSuggestionForAutoCompletion() -> Bool {
        return false
    }

    // MARK: Private API

    func onMore(sender: UIBarButtonItem) {
        let alert = UIAlertController()

        let path = "https://github.com/\(owner)/\(repo)/issues/\(number)"
        let externalURL = URL(string: path)!

        let share = UIAlertAction(title: NSLocalizedString("Share...", comment: ""), style: .default) { _ in
            let safariActivity = TUSafariActivity()
            let controller = UIActivityViewController(activityItems: [externalURL], applicationActivities: [safariActivity])
            controller.popoverPresentationController?.barButtonItem = sender
            self.present(controller, animated: true)
        }
        let safari = UIAlertAction(title: NSLocalizedString("Open in Safari", comment: ""), style: .default) { _ in
            let controller = SFSafariViewController(url: externalURL)
            self.present(controller, animated: true)
        }
        let cancel = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)
        alert.addAction(share)
        alert.addAction(safari)
        alert.addAction(cancel)

        alert.popoverPresentationController?.barButtonItem = sender

        present(alert, animated: true)
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return models
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is NSAttributedStringSizing: return IssueTitleSectionController()
        case is IssueCommentModel: return IssueCommentSectionController(client: client)
        case is IssueLabelsModel: return IssueLabelsSectionController()
        case is IssueStatusModel: return IssueStatusSectionController()
        case is IssueLabeledModel: return IssueLabeledSectionController(owner: owner, repo: repo)
        case is IssueStatusEventModel: return IssueStatusEventSectionController(owner: owner, repo: repo)
        case is IssueDiffHunkModel: return IssueDiffHunkSectionController()
        case is IssueReviewModel: return IssueReviewSectionController()
        case is IssueReferencedModel: return IssueReferencedSectionController(client: client)
        case is IssueReferencedCommitModel: return IssueReferencedCommitSectionController()
        case is IssueRenamedModel: return IssueRenamedSectionController()
        case is IssueRequestModel: return IssueRequestSectionController()
        case is IssueAssigneesModel: return IssueAssigneesSectionController()
        case is IssueMilestoneEventModel: return IssueMilestoneEventSectionController()
        case is IssueCommitModel: return IssueCommitSectionController(owner: owner, repo: repo)
        default: fatalError("Unhandled object: \(object)")
        }
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        switch feed.status {
        case .idle:
            let emptyView = EmptyView()
            emptyView.label.text = NSLocalizedString("Issue cannot be found", comment: "")
            return emptyView
        case .loading, .loadingNext:
            return nil
        }
    }

    // MARK: FeedDelegate

    func loadFromNetwork(feed: Feed) {
        client.fetch(
            owner: owner,
            repo: repo,
            number: number,
            width: view.bounds.width
        ) { subjectId, results, users in
            if let subjectId = subjectId {
                let addCommentClient = AddCommentClient(client: self.client, subjectId: subjectId)
                addCommentClient.addListener(listener: self)
                self.addCommentClient = addCommentClient

                self.autocomplete.add(UserAutocomplete(mentionableUsers: users))
            }

            self.models = results
            self.feed.finishLoading(dismissRefresh: true)
        }
    }

    func loadNextPage(feed: Feed) -> Bool {
        return false
    }

    // MARK: AddCommentListener

    func didSendComment(client: AddCommentClient, id: String, commentFields: CommentFields, reactionFields: ReactionFields) {
        guard let comment = createCommentModel(
            id: id,
            commentFields: commentFields,
            reactionFields: reactionFields,
            width: view.bounds.width,
            threadState: .single
            )
            else { return }
        models.append(comment)

        let collectionView = feed.collectionView
        feed.adapter.performUpdates(animated: false, completion: { _ in
            collectionView.slk_scrollToBottom(animated: true)
        })
    }

    func didFailSendingComment(client: AddCommentClient, body: String) {
        textView.text = body
    }

    // MARK: IssueCommentAutocompleteDelegate

    func didFinish(autocomplete: IssueCommentAutocomplete, hasResults: Bool) {
        showAutoCompletionView(hasResults)
    }

    func didChangeStore(autocomplete: IssueCommentAutocomplete) {
        registerPrefixes(forAutoCompletion: autocomplete.prefixes)
        autoCompletionView.reloadData()
    }
    
    // MARK: FeedSelectionProviding
    
    var feedContainsSelection: Bool {
        return feed.collectionView.indexPathsForSelectedItems?.count != 0
    }
    
}
