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

final class IssuesViewController: SLKTextViewController,
    ListAdapterDataSource,
    FeedDelegate,
    AddCommentListener,
    IssueCommentAutocompleteDelegate,
FeedSelectionProviding,
IssueNeckLoadSectionControllerDelegate,
IssueCommentSectionControllerDelegate {

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

    private var current: IssueResult? = nil {
        didSet {
            let hidden: Bool
            if let current = self.current {
                hidden = current.status.locked && !current.viewerCanUpdate
            } else {
                hidden = true
            }
            self.setTextInputbarHidden(hidden, animated: true)

            // hack required to get textInputBar.contentView + textView laid out correctly
            self.textInputbar.layoutIfNeeded()
        }
    }
    private var sentComments = [ListDiffable]()

    // set to optimistically change the open/closed status
    // clear when refreshing or on request failure
    private var localStatusChange: (model: IssueStatusModel, event: IssueStatusEventModel)? = nil

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

        self.title = issueTitle
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
        textActionsController.configure(textView: textView, actions: actions)

        // using visual format re: https://github.com/slackhq/SlackTextViewController/issues/596
        // i'm not sure exactly what these would be in SnapKit (would pref SK tho)
        let contentView = textInputbar.contentView
        contentView.addSubview(actions)
        let views = ["actions": actions]
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[actions(30)]-4@999-|",
            options: [],
            metrics: nil,
            views: views
        ))
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[actions]|",
            options: [],
            metrics: nil,
            views: views
        ))
        self.textInputbar.layoutIfNeeded()

        let rightItem = UIBarButtonItem(
            image: UIImage(named: "bullets-hollow"),
            style: .plain,
            target: self,
            action: #selector(IssuesViewController.onMore(sender:))
        )
        rightItem.accessibilityLabel = NSLocalizedString("More options", comment: "")
        navigationItem.rightBarButtonItem = rightItem

        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        feed.viewDidAppear(animated)
        let informator = HandoffInformator(
            activityName: "viewIssue",
            activityTitle: issueTitle,
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

        if let subjectId = current?.subjectId,
            let text = text {
            addCommentClient.addComment(
                subjectId: subjectId,
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
    
    var issueTitle: String {
        return "\(model.owner)/\(model.repo)#\(model.number)"
    }

    func closeAction() -> UIAlertAction? {
        guard current?.viewerCanUpdate == true,
            let status = localStatusChange?.model.status ?? current?.status.status,
            status != .merged
            else { return nil }
        
        return AlertAction.toggleIssue(status, issue: current?.pullRequest != true) { [weak self] _ in
            self?.setStatus(close: status == .open)
        }
    }
    
    func lockAction() -> UIAlertAction? {
        guard current?.viewerCanUpdate == true, let locked = localStatusChange?.model.locked ?? current?.status.locked else {
            return nil
        }
        
        return AlertAction.toggleLocked(locked, issue: current?.pullRequest != true) { [weak self] _ in
            self?.setLocked(!locked)
        }
    }
    
    func viewRepoAction() -> UIAlertAction? {
        guard let _ = current else { return nil }
        
        let repo = RepositoryDetails(
            owner: model.owner,
            name: model.repo,
            hasIssuesEnabled: current?.hasIssuesEnabled ?? false
        )
        let repoViewController = RepositoryViewController(client: client, repo: repo)
        weak var weakSelf = self
        
        return AlertAction(AlertActionBuilder { $0.rootViewController = weakSelf })
            .view(repo: repoViewController)
    }

    func bookmarkAction() -> UIAlertAction? {
        guard let current = current else { return nil }
        let bookmarkModel = BookmarkModel(
            type: current.pullRequest ? .pullRequest : .issue,
            name: model.repo,
            owner: model.owner,
            number: model.number,
            title: current.title.attributedText.string
        )
        
        return AlertAction.bookmark(bookmarkModel)
    }
    
    @objc
    func onMore(sender: UIBarButtonItem) {
		let alert = UIAlertController.configured(preferredStyle: .actionSheet)

        weak var weakSelf = self
        let alertBuilder = AlertActionBuilder { $0.rootViewController = weakSelf }
        
        alert.addActions([
            bookmarkAction(),
            closeAction(),
            lockAction(),
            AlertAction(alertBuilder).share([externalURL], activities: [TUSafariActivity()]) { $0.popoverPresentationController?.barButtonItem = sender },
            AlertAction(alertBuilder).openInSafari(url: externalURL),
            viewRepoAction(),
            AlertAction.cancel()
        ])
        alert.popoverPresentationController?.barButtonItem = sender
        
        present(alert, animated: true)
    }

    func fetch(previous: Bool) {
        // on head load, reset all optimistic state
        if !previous {
            localStatusChange = nil
        }

        client.fetch(
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            width: view.bounds.width,
            prependResult: previous ? current : nil
        ) { [weak self] resultType in

            switch resultType {
            case .success(let result):
                // clear pending comments since they should now be part of the payload
                // only clear when doing a refresh load
                if previous {
                    self?.sentComments.removeAll()
                }

                self?.autocomplete.add(UserAutocomplete(mentionableUsers: result.mentionableUsers))
                self?.current = result
            default: break
            }
            self?.feed.finishLoading(dismissRefresh: true) {
                if self?.hasScrolledToBottom != true {
                    self?.hasScrolledToBottom = true
                    self?.feed.collectionView.slk_scrollToBottom(animated: true)
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
        guard let currentStatus = localStatusChange?.model ?? current?.status else { return }

        let localModel = IssueStatusModel(
            status: close ? .closed : .open,
            pullRequest: currentStatus.pullRequest,
            locked: currentStatus.locked
        )
        let localEvent = IssueStatusEventModel(
            id: UUID().uuidString,
            actor: client.sessionManager.focusedUserSession?.username ?? Constants.Strings.unknown,
            commitHash: nil,
            date: Date(),
            status: close ? .closed : .reopened,
            pullRequest: currentStatus.pullRequest
        )

        localStatusChange = (localModel, localEvent)
        feed.adapter.performUpdates(animated: true)

        client.setStatus(
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            status: close ? .closed : .open
        ) { [weak self] result in
            switch result {
            case .error:
                self?.localStatusChange = nil
                self?.feed.adapter.performUpdates(animated: true)
                ToastManager.showGenericError()
            default: break // dont need to handle success since updated optimistically
            }
        }
    }
    
    func setLocked(_ locked: Bool) {
        guard let currentStatus = localStatusChange?.model ?? current?.status else { return }
        
        let localModel = IssueStatusModel(
            status: currentStatus.status,
            pullRequest: currentStatus.pullRequest,
            locked: locked
        )
        let localEvent = IssueStatusEventModel(
            id: UUID().uuidString,
            actor: client.sessionManager.focusedUserSession?.username ?? Constants.Strings.unknown,
            commitHash: nil,
            date: Date(),
            status: locked ? .locked : .unlocked,
            pullRequest: currentStatus.pullRequest
        )
        
        localStatusChange = (localModel, localEvent)
        feed.adapter.performUpdates(animated: true)
        
        client.setLocked(
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            locked: locked
        ) { [weak self] result in
            switch result {
            case .error:
                self?.localStatusChange = nil
                self?.feed.adapter.performUpdates(animated: true)
                ToastManager.showGenericError()
            default: break // dont need to handle success since updated optimistically
            }
        }
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        guard let current = self.current else { return [] }

        var objects: [ListDiffable] = [
            localStatusChange?.model ?? current.status,
            current.title,
            current.labels,
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

        if let event = localStatusChange?.event {
            objects.append(event)
        }

        return objects
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let object = object as? ListDiffable, object === viewFilesModel {
            return IssueViewFilesSectionController(issueModel: model, client: client)
        }

        switch object {
        case is NSAttributedStringSizing: return IssueTitleSectionController()
        case is IssueCommentModel: return IssueCommentSectionController(model: model, client: client, delegate: self)
        case is IssueLabelsModel: return IssueLabelsSectionController(issueModel: model, client: client)
        case is IssueStatusModel: return IssueStatusSectionController()
        case is IssueLabeledModel: return IssueLabeledSectionController(issueModel: model)
        case is IssueStatusEventModel: return IssueStatusEventSectionController(issueModel: model)
        case is IssueDiffHunkModel: return IssueDiffHunkSectionController()
        case is IssueReviewModel: return IssueReviewSectionController(client: client)
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

    // MARK: IssueCommentSectionControllerDelegate

    func didEdit(sectionController: IssueCommentSectionController) {
        
    }

}
