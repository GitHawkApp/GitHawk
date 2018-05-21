//
//  PullRequestReviewCommentsViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import MessageViewController
import StyledText

final class PullRequestReviewCommentsViewController: MessageViewController,
    ListAdapterDataSource,
    FeedDelegate,
    PullRequestReviewReplySectionControllerDelegate {

    private let model: IssueDetailsModel
    private let client: GithubClient
    private let autocomplete: IssueCommentAutocomplete
    private var results = [ListDiffable]()
    private let textActionsController = TextActionsController()
    private var autocompleteController: AutocompleteController!
    private var focusedReplyModel: PullRequestReviewReplyModel?

    lazy private var feed: Feed = {
        let f = Feed(viewController: self, delegate: self, managesLayout: false)
        f.collectionView.contentInset = Styles.Sizes.threadInset
        return f
    }()

    init(model: IssueDetailsModel, client: GithubClient, autocomplete: IssueCommentAutocomplete) {
        self.model = model
        self.client = client
        self.autocomplete = autocomplete

        super.init(nibName: nil, bundle: nil)

        title = NSLocalizedString("Review Comments", comment: "")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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

        actions.frame = CGRect(x: 0, y: 0, width: 0, height: 40)
        messageView.add(contentView: actions)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        feed.viewWillLayoutSubviews(view: view)
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        feed.collectionView.updateSafeInset(container: view, base: Styles.Sizes.threadInset)
        
    }

    // MARK: FeedDelegate

    func loadFromNetwork(feed: Feed) {
        fetch()
    }

    func loadNextPage(feed: Feed) -> Bool {
        return false
    }

    // MARK: Private API

    var insetWidth: CGFloat {
        let contentInset = feed.collectionView.contentInset
        return view.bounds.width - contentInset.left - contentInset.right
    }

    func fetch() {
        client.fetchPRComments(
        owner: model.owner,
        repo: model.repo,
        number: model.number,
        width: insetWidth
        ) { [weak self] (result) in
            switch result {
            case .error: ToastManager.showGenericError()
            case .success(let models):
                self?.results = models
                self?.feed.finishLoading(dismissRefresh: true, animated: true)
            }
        }
    }

    @objc func didPressButton(_ sender: Any) {
        guard let reply = focusedReplyModel else { return }

        let text = messageView.text
        messageView.text = ""
        messageView.textView.resignFirstResponder()
        setMessageView(hidden: true, animated: true)

        client.sendComment(
            body: text,
            inReplyTo: reply.replyID,
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            width: insetWidth
        ) { [weak self] result in
            switch result {
            case .error: break
            case .success(let comment): self?.insertComment(model: comment, reply: reply)
            }
        }

    }

    func insertComment(model: IssueCommentModel, reply: PullRequestReviewReplyModel) {
        let section = feed.adapter.section(for: reply)
        guard section < NSNotFound && section < results.count else { return }

        results.insert(model, at: section)
        feed.adapter.performUpdates(animated: true)
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return results
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is StyledTextRenderer: return IssueTitleSectionController()
        case is IssueCommentModel: return IssueCommentSectionController(
            model: self.model,
            client: client,
            autocomplete: autocomplete
            )
        case is IssueDiffHunkModel: return IssueDiffHunkSectionController()
        case is PullRequestReviewReplyModel: return PullRequestReviewReplySectionController(delegate: self)
        // add case for reply model + SC. connect SC.delegate = self
        default: fatalError("Unhandled object: \(model)")
        }
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        switch feed.status {
        case .idle:
            let emptyView = EmptyView()
            emptyView.label.text = NSLocalizedString("Error loading review comments.", comment: "")
            return emptyView
        case .loadingNext:
            return nil
        case .loading:
            return EmptyLoadingView()
        }
    }

    // MARK: PullRequestReviewReplySectionControllerDelegate

    func didSelect(replySectionController: PullRequestReviewReplySectionController, reply: PullRequestReviewReplyModel) {
        setMessageView(hidden: false, animated: true)
        messageView.textView.becomeFirstResponder()
        feed.adapter.scroll(to: reply, padding: Styles.Sizes.rowSpacing)

        focusedReplyModel = reply
    }

}
