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

final class IssuesViewController: UIViewController, ListAdapterDataSource, FeedDelegate {

    fileprivate let client: GithubClient
    fileprivate let owner: String
    fileprivate let repo: String
    fileprivate let number: Int
    fileprivate var models = [ListDiffable]()
    lazy fileprivate var feed: Feed = { Feed(viewController: self, delegate: self) }()

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

        let rightItem = UIBarButtonItem(
            image: UIImage(named: "bullets"),
            style: .plain,
            target: self,
            action: #selector(IssuesViewController.onMore)
        )
        navigationItem.rightBarButtonItem = rightItem
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        feed.viewWillTransition(to: size, with: coordinator)
    }

    // MARK: Private API

    func onMore() {
        let path = "https://github.com/\(owner)/\(repo)/issues/\(number)"
        let url = URL(string: path)!
        let safari = TUSafariActivity()
        let activity = UIActivityViewController(activityItems: [url], applicationActivities: [safari])
        present(activity, animated: true)
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return models
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is NSAttributedStringSizing {
            return IssueTitleSectionController()
        } else if object is IssueCommentModel {
            return IssueCommentSectionController(client: client)
        } else if object is IssueLabelsModel {
            return IssueLabelsSectionController()
        } else if object is IssueStatusModel {
            return IssueStatusSectionController()
        } else if object is IssueLabeledModel {
            return IssueLabeledSectionController()
        } else if object is IssueClosedModel {
            return IssueClosedSectionController()
        }
        return ListSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        switch feed.status {
        case .idle:
            let emptyView = EmptyView()
            emptyView.label.text = NSLocalizedString("Issue cannot be found", comment: "")
            return emptyView
        case .loading:
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
            self.feed.finishLoading(fromNetwork: true)
        }
    }
    
}
