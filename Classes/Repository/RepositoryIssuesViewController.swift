//
//  RepositoryIssuesViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

enum RepositoryIssuesType {
    case issues
    case pullRequests
}

class RepositoryIssuesViewController: UIViewController,
FeedDelegate {

    private lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()

    private let repo: RepositoryDetails
    private let client: RepositoryClient
    private let type: RepositoryIssuesType

    init(client: GithubClient, repo: RepositoryDetails, type: RepositoryIssuesType) {
        self.repo = repo
        self.client = RepositoryClient(githubClient: client, owner: repo.owner, name: repo.name)
        self.type = type
        super.init(nibName: nil, bundle: nil)

        switch type {
        case .issues: title = NSLocalizedString("Issues", comment: "")
        case .pullRequests: title = NSLocalizedString("Pull Requests", comment: "")
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        switch type {
        case .issues: view.backgroundColor = .red
        case .pullRequests: view.backgroundColor = .blue
        }
    }

    // MARK: Private API

    func fetch() {

    }

    // MARK: FeedDelegate

    func loadFromNetwork(feed: Feed) {
        fetch()
    }

    func loadNextPage(feed: Feed) -> Bool {
        return false
    }

}
