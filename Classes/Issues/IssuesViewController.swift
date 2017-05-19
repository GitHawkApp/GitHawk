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
        guard let issue = self.issue else { return [] }
        let width = view.bounds.width
        let title = createIssueTitleString(issue: issue, width: width)
        return [ title ]
    }

    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if object is NSAttributedStringSizing {
            return IssueTitleSectionController()
        }
        return IGListSectionController()
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }

}

extension IssuesViewController: FeedDelegate {

    func loadFromNetwork(feed: Feed) {
        client.requestIssue(owner: owner, repo: repo, number: number) { result in
            switch result {
            case .success(let issue):
                self.issue = issue
            case .failure: print("nope")
            }
            feed.finishLoading(fromNetwork: true)
        }
    }

}
