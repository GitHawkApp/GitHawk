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
import SnapKit
import FlatCache

final class IssuesViewController: SLKTextViewController,
    ListAdapterDataSource,
    FeedDelegate,
    AddCommentListener,
    IssueCommentAutocompleteDelegate,
FeedSelectionProviding,
IssueNeckLoadSectionControllerDelegate,
FlatCacheListener {

    private let client: GithubClient
    private let model: IssueDetailsModel
    private let addCommentClient: AddCommentClient
    private let autocomplete = IssueCommentAutocomplete(autocompletes: [EmojiAutocomplete()])
    private var hasScrolledToBottom = false
    private let viewFilesModel = "view_files" as ListDiffable
    private let textActionsController = TextActionsController()

    lazy private var feed: Feed = { Feed(
        viewController: self,
        delegate: self,
        collectionView: self.collectionView,
        managesLayout: false
        ) }()

    private var resultID: String? = nil {
        didSet {
            let hidden: Bool
            if let id = resultID,
                let result = self.client.cache.get(id: id) as IssueResult? {
                hidden = result.status.locked && !result.viewerCanUpdate
            } else {
                hidden = true
            }
            self.setTextInputbarHidden(hidden, animated: true)

            // hack required to get textInputBar.contentView + textView laid out correctly
            self.textInputbar.layoutIfNeeded()
        }
    }

    var result: IssueResult? {
        guard let id = resultID else { return nil }
        return client.cache.get(id: id) as IssueResult?
    }

    var moreOptionsItem: UIBarButtonItem {
        let rightItem = UIBarButtonItem(
            image: UIImage(named: "bullets-hollow"),
            style: .plain,
            target: self,
            action: #selector(IssuesViewController.onMore(sender:))
        )
        rightItem.accessibilityLabel = NSLocalizedString("More options", comment: "")
        return rightItem
    }

    private var sentComments = [ListDiffable]()

    init(
        client: GithubClient,
        model: IssueDetailsModel,
        scrollToBottom: Bool = false
        ) {
        self.client = client
        self.model = model
        self.addCommentClient = AddCommentClient(client: client)

        // trick into thinking already scrolled to bottom after load
        self.hasScrolledToBottom = !scrollToBottom

        // force unwrap, this absolutely must work
        super.init(collectionViewLayout: UICollectionViewFlowLayout())!

        self.hidesBottomBarWhenPushed = true
        self.addCommentClient.addListener(listener: self)

        // not registered until request is finished and self.registerPrefixes(...) is called
        // must have user autocompletes
        autocomplete.configure(tableView: autoCompletionView, delegate: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        makeBackBarItemEmpty()

        navigationItem.configure(title: "#\(model.number)", subtitle: "\(model.owner)/\(model.repo)")

        feed.viewDidLoad()
        feed.adapter.dataSource = self

        // override Feed bg color setting
        view.backgroundColor = Styles.Colors.background

        // override default SLKTextViewController values
        isInverted = false
        textView.placeholder = NSLocalizedString("Leave a comment", comment: "")
        textView.placeholderColor = Styles.Colors.Gray.light.color
        textView.keyboardType = .twitter
        textView.layer.borderColor = Styles.Colors.Gray.border.color.cgColor
        textInputbar.backgroundColor = Styles.Colors.Gray.lighter.color
        rightButton.setTitle(NSLocalizedString("Send", comment: ""), for: .normal)
        rightButton.setTitleColor(Styles.Colors.Blue.medium.color, for: .normal)

        collectionView?.keyboardDismissMode = .interactive

        // displayed once an add comment client is created (requires a gql subject id)
        setTextInputbarHidden(true, animated: false)

        let getMarkdownBlock = { [weak self] () -> (String) in
            return self?.textView.text ?? ""
        }
        let actions = IssueTextActionsView.forMarkdown(
            viewController: self,
            getMarkdownBlock: getMarkdownBlock,
            repo: model.repo,
            owner: model.owner,
            addBorder: false,
            supportsImageUpload: false
        )
        // text input bar uses UIVisualEffectView, don't try to match it
        actions.backgroundColor = .clear
        textActionsController.configure(client: client, textView: textView, actions: actions)

        let contentView = textInputbar.contentView
        contentView.addSubview(actions)
        actions.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-4).priority(999)
            make.left.right.equalTo(contentView)
        }
        self.textInputbar.layoutIfNeeded()

        navigationItem.rightBarButtonItem = moreOptionsItem
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        feed.viewDidAppear(animated)
        let informator = HandoffInformator(
            activityName: "viewIssue",
            activityTitle: "\(model.owner)/\(model.repo)#\(model.number)",
            url: externalURL
        )
        setupUserActivity(with: informator)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        invalidateUserActivity()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        feed.viewWillLayoutSubviews(view: view)
    }

    // MARK: SLKTextViewController overrides

    override func keyForTextCaching() -> String? {
        return "issue.\(model.owner).\(model.repo).\(model.number)"
    }

    override func didPressRightButton(_ sender: Any?) {
        // get text before calling super b/c it will clear it
        let text = textView.text

        super.didPressRightButton(sender)

        if let id = resultID,
            let text = text {
            addCommentClient.addComment(
                subjectId: id,
                body: text
            )
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
            acceptAutoCompletion(with: accept + " ", keepPrefix: false)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return autocomplete.cellHeight
    }

    // MARK: Private API

    var externalURL: URL {
        return URL(string: "https://github.com/\(model.owner)/\(model.repo)/issues/\(model.number)")!
    }

    var bookmark: Bookmark? {
        guard let result = result else { return nil }
        return Bookmark(
            type: result.pullRequest ? .pullRequest : .issue,
            name: model.repo,
            owner: model.owner,
            number: model.number,
            title: result.title.attributedText.string,
            defaultBranch: result.defaultBranch
        )
    }

    func configureBookmarkButton() {
        guard let store = client.bookmarksStore,
            let bookmark = bookmark else { return }

        let isNewBookmark = !store.contains(bookmark)
        let bookmarkItem = UIBarButtonItem(
            image: isNewBookmark ? UIImage(named: "nav-bookmark") : UIImage(named: "nav-bookmark-selected"),
            style: .plain,
            target: self,
            action: #selector(IssuesViewController.toggleBookmark(sender:))
        )
        bookmarkItem.accessibilityLabel = NSLocalizedString("Bookmark", comment: "")
        navigationItem.rightBarButtonItems = [moreOptionsItem, bookmarkItem]
    }

    @objc
    func toggleBookmark(sender: UIBarButtonItem) {
        guard let store = client.bookmarksStore,
            let bookmark = bookmark else { return }

        if !store.contains(bookmark) {
            store.add(bookmark)
            sender.image = UIImage(named: "nav-bookmark-selected")
        } else {
            store.remove(bookmark)
            sender.image = UIImage(named: "nav-bookmark")
        }
        Haptic.triggerNotification(.success)
    }

    func closeAction() -> UIAlertAction? {
        guard result?.viewerCanUpdate == true,
            let status = result?.status.status,
            status != .merged
            else { return nil }

        return AlertAction.toggleIssue(status) { [weak self] _ in
            self?.setStatus(close: status == .open)
            Haptic.triggerNotification(.success)
        }
    }

    func lockAction() -> UIAlertAction? {
        guard result?.viewerCanUpdate == true, let locked = result?.status.locked else {
            return nil
        }

        return AlertAction.toggleLocked(locked) { [weak self] _ in
            self?.setLocked(!locked)
            Haptic.triggerNotification(.success)
        }
    }

    func viewRepoAction() -> UIAlertAction? {
        guard let result = result else { return nil }
        
        let repo = RepositoryDetails(
            owner: model.owner,
            name: model.repo,
            defaultBranch: result.defaultBranch,
            hasIssuesEnabled: result.hasIssuesEnabled
        )

        weak var weakSelf = self
        return AlertAction(AlertActionBuilder { $0.rootViewController = weakSelf })
            .view(client: client, repo: repo)
    }

    @objc
    func onMore(sender: UIBarButtonItem) {
        let issueType = result?.pullRequest == true
            ? Constants.Strings.pullRequest
            : Constants.Strings.issue
        
        let alertTitle = "\(issueType) #\(model.number)"
        
        let alert = UIAlertController.configured(title: alertTitle, preferredStyle: .actionSheet)

        weak var weakSelf = self
        let alertBuilder = AlertActionBuilder { $0.rootViewController = weakSelf }

        alert.addActions([
            closeAction(),
            lockAction(),
            AlertAction(alertBuilder).share([externalURL], activities: [TUSafariActivity()]) { $0.popoverPresentationController?.barButtonItem = sender },
            viewRepoAction(),
            AlertAction.cancel()
        ])
        alert.popoverPresentationController?.barButtonItem = sender

        present(alert, animated: true)
    }

    func fetch(previous: Bool) {
        client.fetch(
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            width: view.bounds.width,
            prependResult: previous ? result : nil
        ) { [weak self] resultType in
            guard let strongSelf = self else { return }

            let isFirstUpdate = strongSelf.resultID == nil

            switch resultType {
            case .success(let result, let mentionableUsers):
                // clear pending comments since they should now be part of the payload
                // only clear when doing a refresh load
                if !previous {
                    strongSelf.sentComments.removeAll()
                }

                strongSelf.autocomplete.add(UserAutocomplete(mentionableUsers: mentionableUsers))
                strongSelf.client.cache.add(listener: strongSelf, value: result)
                strongSelf.resultID = result.id

//                if !previous {
//                    strongSelf.client.fetchPRComments(previous: result, owner: strongSelf.model.owner, repo: strongSelf.model.repo, number: strongSelf.model.number, width: strongSelf.view.bounds.width)
//                }

            default: break
            }

            // subsequent updates are handled by the FlatCacheListener
            if isFirstUpdate {
                strongSelf.configureBookmarkButton()
                strongSelf.feed.finishLoading(dismissRefresh: true) {
                    if strongSelf.hasScrolledToBottom != true {
                        strongSelf.hasScrolledToBottom = true
                        strongSelf.feed.collectionView.slk_scrollToBottom(animated: true)
                    }
                }
            }
        }
    }

    func onPreview() {
        let controller = IssuePreviewViewController(
            markdown: textView.text,
            owner: model.owner,
            repo: model.repo
        )
        showDetailViewController(controller, sender: nil)
    }

    func setStatus(close: Bool) {
        guard let previous = result else { return }

        client.setStatus(
            previous: previous,
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            close: close
        )
    }

    func setLocked(_ locked: Bool) {
        guard let previous = result else { return }
        client.setLocked(
            previous: previous,
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            locked: locked
        )
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        guard let current = self.result else { return [] }

        var objects: [ListDiffable] = [
            current.status,
            current.title,
            current.labels
        ]

        if let milestone = current.milestone {
            objects.append(milestone)
        }

        objects.append(current.assignee)

        if let reviewers = current.reviewers {
            objects.append(reviewers)
        }

        if current.pullRequest {
            objects.append(viewFilesModel)
        }

        if current.hasPreviousPage {
            objects.append(IssueNeckLoadModel())
        }

        if let rootComment = current.rootComment {
            objects.append(rootComment)
        }

        objects += current.timelineViewModels
        objects += sentComments

        return objects
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let object = object as? ListDiffable, object === viewFilesModel {
            return IssueViewFilesSectionController(issueModel: model, client: client)
        }

        switch object {
        case is NSAttributedStringSizing: return IssueTitleSectionController()
        case is IssueCommentModel: return IssueCommentSectionController(model: model, client: client)
        case is IssueLabelsModel: return IssueLabelsSectionController(issueModel: model, client: client)
        case is IssueStatusModel: return IssueStatusSectionController()
        case is IssueLabeledModel: return IssueLabeledSectionController(issueModel: model)
        case is IssueStatusEventModel: return IssueStatusEventSectionController(issueModel: model)
        case is IssueDiffHunkModel: return IssueDiffHunkSectionController()
        case is IssueReviewModel: return IssueReviewSectionController(model: model, client: client)
        case is IssueReferencedModel: return IssueReferencedSectionController(client: client)
        case is IssueReferencedCommitModel: return IssueReferencedCommitSectionController()
        case is IssueRenamedModel: return IssueRenamedSectionController()
        case is IssueRequestModel: return IssueRequestSectionController()
        case is IssueAssigneesModel: return IssueAssigneesSectionController()
        case is IssueMilestoneEventModel: return IssueMilestoneEventSectionController()
        case is IssueCommitModel: return IssueCommitSectionController(issueModel: model)
        case is IssueNeckLoadModel: return IssueNeckLoadSectionController(delegate: self)
        case is IssueMilestoneModel: return IssueMilestoneSectionController(issueModel: model)
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
        fetch(previous: false)
    }

    func loadNextPage(feed: Feed) -> Bool {
        return false
    }

    // MARK: AddCommentListener

    func didSendComment(
        client: AddCommentClient,
        id: String,
        commentFields: CommentFields,
        reactionFields: ReactionFields,
        viewerCanUpdate: Bool,
        viewerCanDelete: Bool
        ) {
        guard let comment = createCommentModel(
            id: id,
            commentFields: commentFields,
            reactionFields: reactionFields,
            width: view.bounds.width,
            owner: model.owner,
            repo: model.repo,
            threadState: .single,
            viewerCanUpdate: viewerCanUpdate,
            viewerCanDelete: viewerCanDelete,
            isRoot: false
            )
            else { return }
        sentComments.append(comment)

        let collectionView = feed.collectionView
        feed.adapter.performUpdates(animated: false, completion: { _ in
            collectionView.slk_scrollToBottom(animated: true)
        })
    }

    func didFailSendingComment(client: AddCommentClient, subjectId: String, body: String) {
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

    // MARK: IssueNeckLoadSectionControllerDelegate

    func didSelect(sectionController: IssueNeckLoadSectionController) {
        fetch(previous: true)
    }

    // MARK: FlatCacheListener

    func flatCacheDidUpdate(cache: FlatCache, update: FlatCache.Update) {
        switch update {
        case .item(let item):
            guard item is IssueResult else { break }
            feed.finishLoading(dismissRefresh: true)
        case .list: break
        }
    }

}
