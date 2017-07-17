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

final class IssuesViewController: UIViewController, ListAdapterDataSource, FeedDelegate, AddCommentListener {

    private let client: GithubClient
    private let owner: String
    private let repo: String
    private let number: Int

    private var newCommentToken: IssueNewCommentToken? = nil
    private var models = [ListDiffable]()
    lazy private var feed: Feed = { Feed(viewController: self, delegate: self) }()

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
        super.init(nibName: nil, bundle: nil)
        title = "\(owner)/\(repo)#\(number)"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        feed.viewDidLoad()
        feed.adapter.dataSource = self

        resetContentInsets()

        let rightItem = UIBarButtonItem(
            image: UIImage(named: "bullets-hollow"),
            style: .plain,
            target: self,
            action: #selector(IssuesViewController.onMore(sender:))
        )
        navigationItem.rightBarButtonItem = rightItem

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(IssuesViewController.onKeyboardDidShow(notification:)),
            name: NSNotification.Name.UIKeyboardDidShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(IssuesViewController.onKeyboardWillHide(notification:)),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        feed.viewWillLayoutSubviews(view: view)
    }

    // MARK: Private API

    func resetContentInsets() {
        var inset = feed.collectionView.contentInset
        inset.bottom = Styles.Sizes.rowSpacing
        feed.collectionView.contentInset = inset
    }

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
        var objects = models
        if let token = newCommentToken {
            objects.append(token)
        }
        return objects
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let object = object as? IssueNewCommentToken {
            let addCommentClient = AddCommentClient(client: client, subjectId: object.subjectId)
            addCommentClient.addListener(listener: self)
            return IssueNewCommentSectionController(client: addCommentClient)
        }

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
        ) { subjectId, results in
            if let subjectId = subjectId {
                self.newCommentToken = IssueNewCommentToken(subjectId)
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
        feed.adapter.performUpdates(animated: true)
    }
    
    func didFailSendingComment(client: AddCommentClient) {}

    // MARK: Notifications

    func onKeyboardDidShow(notification: NSNotification) {
        guard let size = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect)?.size else { return }
        let collectionView = feed.collectionView

        var inset = collectionView.contentInset
        inset.bottom = size.height + Styles.Sizes.gutter
        collectionView.contentInset = inset

        var scrollInset = UIEdgeInsets.zero
        scrollInset.bottom = size.height
        collectionView.scrollIndicatorInsets = scrollInset

        // knowing that the comment field is at the bottom, just scroll all the way down
        var offset = collectionView.contentOffset
        offset.y = collectionView.contentSize.height + collectionView.contentInset.bottom - collectionView.bounds.height
        collectionView.setContentOffset(offset, animated: true)
    }

    func onKeyboardWillHide(notification: NSNotification) {
        resetContentInsets()
    }
    
}
