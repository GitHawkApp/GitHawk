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

final class IssuesViewController: UIViewController, ListAdapterDataSource, FeedDelegate {

    private let client: GithubClient
    private let owner: String
    private let repo: String
    private let number: Int

    private var models = [ListDiffable]()
    lazy private var feed: Feed = { Feed(viewController: self, delegate: self) }()
    private let addCommentButton = WriteButton()

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

        var inset = feed.collectionView.contentInset
        inset.bottom = addCommentButton.preferredSize.height + Styles.Sizes.gutter + Styles.Sizes.rowSpacing
        feed.collectionView.contentInset = inset

        addCommentButton.addTarget(self, action: #selector(IssuesViewController.onAddComment), for: .touchUpInside)
        view.addSubview(addCommentButton)
        addCommentButton.snp.makeConstraints { make in
            make.size.equalTo(addCommentButton.preferredSize)
            make.right.equalTo(view).offset(-Styles.Sizes.gutter)
            make.bottom.equalTo(view).offset(-Styles.Sizes.gutter)
        }

        let rightItem = UIBarButtonItem(
            image: UIImage(named: "bullets-hollow"),
            style: .plain,
            target: self,
            action: #selector(IssuesViewController.onMore(sender:))
        )
        navigationItem.rightBarButtonItem = rightItem
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        feed.viewWillLayoutSubviews(view: view)
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

    func onAddComment() {
        let controller = UINavigationController(rootViewController: NewCommentViewController())
        controller.modalPresentationStyle = .formSheet
        present(controller, animated: true)
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
        ) { results in
            self.models = results
            self.feed.finishLoading(dismissRefresh: true)
        }
    }

    func loadNextPage(feed: Feed) -> Bool {
        return false
    }
    
}
