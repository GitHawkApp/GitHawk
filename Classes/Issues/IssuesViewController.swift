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
import SnapKit
import FlatCache
import MessageViewController

final class IssuesViewController:
    MessageViewController,
    ListAdapterDataSource,
    FeedDelegate,
    AddCommentListener,
    FeedSelectionProviding,
    IssueNeckLoadSectionControllerDelegate,
    FlatCacheListener,
    IssueManagingNavSectionControllerDelegate,
    IssueCommentSectionControllerDelegate {

    private let client: GithubClient
    private let model: IssueDetailsModel
    private let addCommentClient: AddCommentClient
    private let textActionsController = TextActionsController()
    private var bookmarkNavController: BookmarkNavigationController? = nil
    private var autocompleteController: AutocompleteController!

    private var needsScrollToBottom = false
    private var lastTimelineElement: ListDiffable?

    // must fetch collaborator info from API before showing editing controls
    private var viewerIsCollaborator = false
    private let manageKey = "manageKey" as ListDiffable

    lazy private var feed: Feed = {
        let f = Feed(viewController: self, delegate: self, managesLayout: false)
        f.collectionView.contentInset = Styles.Sizes.threadInset
        return f
    }()

    private var resultID: String? = nil {
        didSet {
            let hidden: Bool
            if let id = resultID,
                let result = self.client.cache.get(id: id) as IssueResult? {
                hidden = result.status.locked && !viewerIsCollaborator

                let bookmark = Bookmark(
                    type: result.pullRequest ? .pullRequest : .issue,
                    name: self.model.repo,
                    owner: self.model.owner,
                    number: self.model.number,
                    title: result.title.string.allText,
                    defaultBranch: result.defaultBranch
                )
                self.bookmarkNavController = BookmarkNavigationController(store: client.bookmarksStore, model: bookmark)
                self.configureNavigationItems()
            } else {
                hidden = true
            }
            self.setMessageView(hidden: hidden, animated: trueUnlessReduceMotionEnabled)
        }
    }

    var result: IssueResult? {
        guard let id = resultID else { return nil }
        return client.cache.get(id: id) as IssueResult?
    }

    var moreOptionsItem: UIBarButtonItem {
        let rightItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(IssuesViewController.onMore(sender:))
        )
        rightItem.accessibilityLabel = NSLocalizedString("Share", comment: "")
        return rightItem
    }

    init(
        client: GithubClient,
        model: IssueDetailsModel,
        scrollToBottom: Bool = false
        ) {
        self.client = client
        self.model = model
        self.addCommentClient = AddCommentClient(client: client)
        self.needsScrollToBottom = scrollToBottom

        super.init(nibName: nil, bundle: nil)

        self.autocompleteController = AutocompleteController(
            messageAutocompleteController: messageAutocompleteController,
            autocomplete: IssueCommentAutocomplete(autocompletes: [EmojiAutocomplete()])
        )

        self.hidesBottomBarWhenPushed = true
        self.addCommentClient.addListener(listener: self)

        cacheKey = "issue.\(model.owner).\(model.repo).\(model.number)"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        makeBackBarItemEmpty()

        let labelFormat = NSLocalizedString("#%d in repository %@ by %@", comment: "Accessibility label for an issue/pull request navigation item")
        let labelString = String(format: labelFormat, arguments: [model.number, model.repo, model.owner])

        let navigationTitle = NavigationTitleDropdownView()
        navigationTitle.addTarget(self, action: #selector(onNavigationTitle(sender:)), for: .touchUpInside)
        navigationTitle.configure(
            title: "#\(model.number)",
            subtitle: "\(model.owner)/\(model.repo)",
            accessibilityLabel: labelString,
            accessibilityHint: NSLocalizedString(
                "Gives the option to view the repository's overview or owner",
                comment: "The hint for tapping the navigationBar's repository information.")
        )
        navigationItem.titleView = navigationTitle

        feed.viewDidLoad()
        feed.adapter.dataSource = self

        // setup after feed is lazy loaded
        setup(scrollView: feed.collectionView)
        setMessageView(hidden: true, animated: false)

        // override Feed bg color setting
        view.backgroundColor = Styles.Colors.background

        // setup message view properties
        configure(target: self, action: #selector(didPressButton(_:)))

        let getMarkdownBlock = { [weak self] () -> (String) in
            return self?.messageView.text ?? ""
        }
        let actions = IssueTextActionsView.forMarkdown(
            viewController: self,
            getMarkdownBlock: getMarkdownBlock,
            repo: model.repo,
            owner: model.owner,
            addBorder: false,
            supportsImageUpload: true
        )
        // text input bar uses UIVisualEffectView, don't try to match it
        actions.backgroundColor = .clear

        textActionsController.configure(client: client, textView: messageView.textView, actions: actions)
        textActionsController.viewController = self

        actions.frame = CGRect(x: 0, y: 0, width: 0, height: 32)
        messageView.add(contentView: actions)

        
        //show disabled bookmark button until issue has finished loading
        navigationItem.rightBarButtonItems = [ moreOptionsItem, BookmarkNavigationController.disabledNavigationItem ]
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        feed.collectionView.updateSafeInset(container: view, base: Styles.Sizes.threadInset)
    }

    // MARK: Private API

    @objc func didPressButton(_ sender: Any?) {
        // get text before calling super b/c it will clear it
        let text = messageView.text
        messageView.text = ""

        if let id = resultID {
            addCommentClient.addComment(
                subjectId: id,
                body: text
            )
        }
    }

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
            title: result.title.string.allText,
            defaultBranch: result.defaultBranch
        )
    }

    func configureNavigationItems() {
        guard let rightbarButtonItems = navigationItem.rightBarButtonItems else { return }
        guard let bookmarkItem = rightbarButtonItems.last else { return }
        bookmarkNavController?.configureNavigationItem(bookmarkItem)
    }

    func viewRepoAction() -> UIAlertAction? {
        guard let result = result else { return nil }
        return action(
            owner: model.owner,
            repo: model.repo,
            branch: result.defaultBranch,
            issuesEnabled: result.hasIssuesEnabled,
            client: client
        )
    }

    @objc func onMore(sender: UIBarButtonItem) {
        let activityController = UIActivityViewController(
            activityItems: [externalURL],
            applicationActivities: [TUSafariActivity()]
        )
        activityController.popoverPresentationController?.barButtonItem = sender
        present(activityController, animated: trueUnlessReduceMotionEnabled)
    }

    func fetch(previous: Bool) {
        if !previous {
            client.fetchViewerCollaborator(
                owner: model.owner,
                repo: model.repo
            ) { [weak self] (result) in
                switch result {
                case .success(let permission):
                    let collab: Bool
                    switch permission {
                    case .admin, .write: collab = true
                    case .read, .none: collab = false
                    }
                    self?.viewerIsCollaborator = collab
                    // avoid finishLoading() so empty view doesn't appear
                    self?.feed.adapter.performUpdates(animated: trueUnlessReduceMotionEnabled)
                case .error:
                    ToastManager.showGenericError()
                }
            }
        }

        // assumptions here, but the collectionview may not have been laid out or content size found
        // assume the collectionview is pinned to the view's bounds
        let contentInset = feed.collectionView.contentInset
        let width = view.bounds.width - contentInset.left - contentInset.right

        client.fetch(
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            width: width,
            prependResult: previous ? result : nil
        ) { [weak self] resultType in
            guard let strongSelf = self else { return }

            let isFirstUpdate = strongSelf.resultID == nil

            switch resultType {
            case .success(let result, let mentionableUsers):
                strongSelf.autocompleteController.autocomplete.add(
                    UserAutocomplete(mentionableUsers: mentionableUsers)
                )
                strongSelf.client.cache.add(listener: strongSelf, value: result)
                strongSelf.resultID = result.id
            default: break
            }

            // subsequent updates are handled by the FlatCacheListener
            if isFirstUpdate {
                strongSelf.updateAndScrollIfNeeded()
            }
        }
    }

    func updateAndScrollIfNeeded(dismissRefresh: Bool = true) {
        feed.finishLoading(dismissRefresh: dismissRefresh) { [weak self] in
            if self?.needsScrollToBottom == true {
                self?.needsScrollToBottom = false
                self?.scrollToLastContentElement()
            }
        }
    }

    func scrollToLastContentElement() {
        guard let lastTimeline = lastTimelineElement else { return }

        // assuming the last element is the "actions" when collaborator
        feed.adapter.scroll(to: lastTimeline, padding: Styles.Sizes.rowSpacing)
    }

    func onPreview() {
        let controller = IssuePreviewViewController(
            markdown: messageView.text,
            owner: model.owner,
            repo: model.repo
        )
        showDetailViewController(controller, sender: nil)
    }

    @objc func onNavigationTitle(sender: UIView) {
        let alert = UIAlertController.configured(preferredStyle: .actionSheet)
        alert.addActions([
            action(owner: model.owner),
            viewRepoAction(),
            AlertAction.cancel()
            ])
        alert.popoverPresentationController?.setSourceView(sender)
        present(alert, animated: trueUnlessReduceMotionEnabled)
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        guard let current = self.result else { return [] }

        var objects: [ListDiffable] = [current.status]

        if viewerIsCollaborator {
            objects.append(manageKey)
        }

        // BEGIN collect metadata that lives between title and root comment
        var metadata = [ListDiffable]()
        if current.labels.labels.count > 0 {
            metadata.append(current.labels)
        }
        if let milestone = current.milestone {
            metadata.append(milestone)
        }
        if current.assignee.users.count > 0 {
            metadata.append(current.assignee)
        }
        if let reviewers = current.reviewers {
            metadata.append(reviewers)
        }
        if let changes = current.fileChanges {
            metadata.append(IssueFileChangesModel(changes: changes))
        }
        // END metadata collection
        
        objects.append(IssueTitleModel(string: current.title, trailingMetadata: metadata.count > 0))
        
        if let targetBranch = current.targetBranch {
            objects.append(targetBranch)
        }

        objects += metadata

        if let rootComment = current.rootComment {
            objects.append(rootComment)
        }

        if current.hasPreviousPage {
            objects.append(IssueNeckLoadModel())
        }

        objects += current.timelineViewModels

        // side effect so to jump to the last element when auto scrolling
        lastTimelineElement = objects.last

        if viewerIsCollaborator || current.viewerCanUpdate {
            objects.append(IssueManagingModel(
                objectId: current.id,
                pullRequest: current.pullRequest,
                role: viewerIsCollaborator ? .collaborator : .author
            ))
        }
        
        if viewerIsCollaborator,
            current.status.status == .open,
            let merge = current.mergeModel {
            objects.append(merge)
        }

        return objects
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let object = object as? ListDiffable, object === manageKey {
            return IssueManagingNavSectionController(delegate: self)
        }

        switch object {
        case is IssueTitleModel: return IssueTitleSectionController()
        case is IssueCommentModel:
            return IssueCommentSectionController(
                model: model,
                client: client,
                autocomplete: autocompleteController.autocomplete.copy,
                issueCommentDelegate: self
            )
        case is IssueLabelsModel: return IssueLabelsSectionController(issue: model)
        case is IssueStatusModel: return IssueStatusSectionController()
        case is IssueLabeledModel: return IssueLabeledSectionController(issueModel: model)
        case is IssueStatusEventModel: return IssueStatusEventSectionController(issueModel: model)
        case is IssueDiffHunkModel: return IssueDiffHunkSectionController()
        case is IssueReviewModel: return IssueReviewSectionController(
            model: model,
            client: client,
            autocomplete: autocompleteController.autocomplete.copy
            )
        case is IssueReferencedModel: return IssueReferencedSectionController(client: client)
        case is IssueReferencedCommitModel: return IssueReferencedCommitSectionController()
        case is IssueRenamedModel: return IssueRenamedSectionController()
        case is IssueRequestModel: return IssueRequestSectionController()
        case is IssueAssigneesModel: return IssueAssigneesSectionController()
        case is IssueMilestoneEventModel: return IssueMilestoneEventSectionController()
        case is IssueCommitModel: return IssueCommitSectionController(issueModel: model)
        case is IssueNeckLoadModel: return IssueNeckLoadSectionController(delegate: self)
        case is Milestone: return IssueMilestoneSectionController(issueModel: model)
        case is IssueFileChangesModel: return IssueViewFilesSectionController(issueModel: model, client: client)
        case is IssueManagingModel: return IssueManagingSectionController(model: model, client: client)
        case is IssueMergeModel: return IssueMergeSectionController(model: model, client: client, resultID: resultID)
        case is IssueTargetBranchModel: return IssueTargetBranchSectionController()
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
        guard let previous = result,
            let comment = createCommentModel(
                id: id,
                commentFields: commentFields,
                reactionFields: reactionFields,
                contentSizeCategory: UIApplication.shared.preferredContentSizeCategory,
                width: view.bounds.width,
                owner: model.owner,
                repo: model.repo,
                threadState: .single,
                viewerCanUpdate: viewerCanUpdate,
                viewerCanDelete: viewerCanDelete,
                isRoot: false
            )
            else { return }

        needsScrollToBottom = true

        let newResult = previous.updated(
            timelinePages: previous.timelinePages(appending: [comment])
        )
        self.client.cache.set(value: newResult)
    }

    func didFailSendingComment(client: AddCommentClient, subjectId: String, body: String) {
        messageView.text = body
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
            updateAndScrollIfNeeded()
        case .list: break
        }
    }

    // MARK: IssueManagingNavSectionControllerDelegate

    func didSelect(managingNavController: IssueManagingNavSectionController) {
        feed.collectionView.scrollToBottom(animated: true)
    }

    // MARK: IssueCommentSectionControllerDelegate

    func didSelectReply(to sectionController: IssueCommentSectionController, commentModel: IssueCommentModel) {
        setMessageView(hidden: false, animated: true)
        messageView.textView.becomeFirstResponder()
        let quote = getCommentUntilNewLine(from: commentModel.rawMarkdown)
        messageView.text = ">\(quote)\n\n@\(commentModel.details.login)"

        feed.adapter.scroll(to: commentModel, padding: Styles.Sizes.rowSpacing)
    }

    private func getCommentUntilNewLine(from string: String) -> String {
        let substring = string.components(separatedBy: .newlines)[0]
        if string == substring {
            return string
        }
        return substring + " ..."
    }

}
