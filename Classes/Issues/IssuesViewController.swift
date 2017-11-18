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
    private let viewFilesModel = "view_files" as ListDiffable
    private let textActionsController = TextActionsController()
    private var bookmarkNavController: BookmarkNavigationController? = nil
    private var needsScrollToBottom = false

    // must fetch collaborator info from API before showing editing controls
    private var viewerIsCollaborator = false
    private let collaboratorKey = "collaborator" as ListDiffable

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

                let bookmark = Bookmark(
                    type: result.pullRequest ? .pullRequest : .issue,
                    name: self.model.repo,
                    owner: self.model.owner,
                    number: self.model.number,
                    title: result.title.attributedText.string,
                    defaultBranch: result.defaultBranch
                )
                self.bookmarkNavController = BookmarkNavigationController(store: client.bookmarksStore, model: bookmark)
                self.configureNavigationItems()
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
        let rightItem = UIBarButtonItem(image: UIImage(named: "bullets-hollow"), target: self, action: #selector(IssuesViewController.onMore(sender:)))
        rightItem.accessibilityLabel = NSLocalizedString("More options", comment: "")
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

        // force unwrap, this absolutely must work
        super.init(collectionViewLayout: ListCollectionViewLayout.basic())!

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
            supportsImageUpload: true
        )
        // text input bar uses UIVisualEffectView, don't try to match it
        actions.backgroundColor = .clear
        
        textActionsController.configure(client: client, textView: textView, actions: actions)
        textActionsController.viewController = self
        
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

    func configureNavigationItems() {
        var items = [moreOptionsItem]
        if let bookmarkItem = bookmarkNavController?.navigationItem {
            items.append(bookmarkItem)
        }
        navigationItem.rightBarButtonItems = items
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

    @objc func onMore(sender: UIButton) {
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
            AlertAction(alertBuilder).share([externalURL], activities: [TUSafariActivity()]) {
                $0.popoverPresentationController?.setSourceView(sender)
            },
            viewRepoAction(),
            AlertAction.cancel()
        ])
        alert.popoverPresentationController?.setSourceView(sender)
        
        present(alert, animated: true)
    }

    func fetch(previous: Bool) {
        if !previous {
            client.fetchViewerCollaborator(
                owner: model.owner,
                repo: model.repo
            ) { [weak self] (result) in
                switch result {
                case .success(let permission):
                    self?.viewerIsCollaborator = permission.canManage
                    // avoid finishLoading() so empty view doesn't appear
                    self?.feed.adapter.performUpdates(animated: true)
                case .error:
                    ToastManager.showGenericError()
                }
            }
        }

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
                strongSelf.autocomplete.add(UserAutocomplete(mentionableUsers: mentionableUsers))
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
                self?.feed.collectionView.slk_scrollToBottom(animated: true)
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

        var objects: [ListDiffable] = [current.status]

        if viewerIsCollaborator {
            objects.append(collaboratorKey)
        }

        objects.append(current.title)
        objects.append(current.labels)

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

        return objects
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let object = object as? ListDiffable else { fatalError("Must be diffable") }

        if object === viewFilesModel {
            return IssueViewFilesSectionController(issueModel: model, client: client)
        } else if object === collaboratorKey, let id = resultID {
            return IssueManagingSectionController(id: id, model: model, client: client)
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
        case is Milestone: return IssueMilestoneSectionController(issueModel: model)
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
            updateAndScrollIfNeeded()
        case .list: break
        }
    }

}
