//
//  IssuesViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssuesViewController: UIViewController {

    fileprivate let client: GithubClient
    fileprivate let owner: String
    fileprivate let repo: String
    fileprivate let number: String
    fileprivate var issue: Issue?
    fileprivate var models = [IGListDiffable]()
    lazy fileprivate var feed: Feed = { Feed(viewController: self, delegate: self) }()

    init(
        client: GithubClient,
        owner: String,
        repo: String,
        number: String
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

}

extension IssuesViewController: IGListAdapterDataSource {

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

}

extension IssuesViewController: FeedDelegate {

    private func createModels(_ issue: Issue) {
        self.issue = issue
        createViewModels(issue: issue, width: self.view.bounds.width) { results in
            self.models = results
            self.feed.finishLoading(fromNetwork: true)
        }
    }

    func loadFromNetwork(feed: Feed) {
        client.requestIssue(owner: owner, repo: repo, number: number) { result in
            switch result {
            case .success(let issue):
                self.createModels(issue)
            case .failure: print("nope")
                feed.finishLoading(fromNetwork: true)
            }
        }
    }
    
}
