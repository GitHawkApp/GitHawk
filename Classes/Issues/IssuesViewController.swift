//
//  IssuesViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssuesViewController: UIViewController, IGListAdapterDataSource, FeedDelegate {

    fileprivate let client: GithubClient
    fileprivate let owner: String
    fileprivate let repo: String
    fileprivate let number: Int
    fileprivate var issue: IssueQuery.Data.Repository.Issue?
    fileprivate var models = [IGListDiffable]()
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
    }

    // MARK: IGListAdapterDataSource

    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return models
    }

    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if object is NSAttributedStringSizing {
            return IssueTitleSectionController()
        } else if object is IssueCommentModel {
            return IssueCommentSectionController()
        } else if object is IssueLabelsModel {
            return IssueLabelsSectionController()
        }
        return IGListSectionController()
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }

    // MARK: FeedDelegate

    private func createModels(_ issue: IssueQuery.Data.Repository.Issue) {
        self.issue = issue
        createViewModels(issue: issue, width: self.view.bounds.width) { results in
            self.models = results
            self.feed.finishLoading(fromNetwork: true)
        }
    }

    func loadFromNetwork(feed: Feed) {
        client.apollo.fetch(query: IssueQuery(owner: owner, repo: repo, number: number)) { (result, error) in
            if let issue = result?.data?.repository?.issue {
                self.createModels(issue)
            } else {
                feed.finishLoading(fromNetwork: true)
            }
        }
    }

}
