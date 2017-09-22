//
//  RepositoryIssuesViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

enum RepositoryIssuesType {
    case issues
    case pullRequests
}

class RepositoryIssuesViewController: UIViewController,
FeedDelegate,
ListAdapterDataSource,
LoadMoreSectionControllerDelegate {

    private lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()

    private let repo: RepositoryDetails
    private let client: RepositoryClient
    private let type: RepositoryIssuesType

    private var models = [RepositoryIssueSummaryModel]()
    private var nextPage: String? = nil
    private let loadMoreKey = "loadMoreKey" as ListDiffable
    private let noResultsKey = "noResultsKey" as ListDiffable

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

        feed.viewDidLoad()
        feed.adapter.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(collectionView: feed.collectionView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        feed.viewWillLayoutSubviews(view: view)
    }

    // MARK: Private API

    func fetch(nextPage: Bool) {
        let page = nextPage ? self.nextPage : nil
        let width = view.bounds.width
        let block = { [weak self] (result: Result<RepositoryClient.RepositoryPayload>) in
            switch result {
            case .error: break
            case .success(let payload):
                self?.models = payload.models
                self?.nextPage = payload.nextPage
                self?.feed.finishLoading(dismissRefresh: true, animated: !nextPage)
            }
        }

        switch type {
        case .issues: client.loadIssues(nextPage: page, containerWidth: width, completion: block)
        case .pullRequests: client.loadPullRequests(nextPage: page, containerWidth: width, completion: block)
        }
    }

    // MARK: FeedDelegate

    func loadFromNetwork(feed: Feed) {
        fetch(nextPage: false)
    }

    func loadNextPage(feed: Feed) -> Bool {
        return false
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var models: [ListDiffable] = self.models
        if nextPage != nil {
            models.append(loadMoreKey)
        }
        return models
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let object = object as? ListDiffable else { fatalError("Object does not conform to ListDiffable") }

        if object === noResultsKey {
            let empty: RepositoryEmptyResultsType
            switch type {
            case .issues: empty = .issues
            case .pullRequests: empty = .pullRequests
            }
            return RepositoryEmptyResultsSectionController(
                topInset: 0,
                topLayoutGuide: topLayoutGuide,
                bottomLayoutGuide: bottomLayoutGuide,
                type: empty
            )
        } else if object === loadMoreKey {
            return LoadMoreSectionController(delegate: self)
        } else if object is RepositoryIssueSummaryModel {
            return RepositorySummarySectionController(client: client.githubClient, repo: repo)
        }

        fatalError("Could not find section controller for object")
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

    // MARK: LoadMoreSectionControllerDelegate

    func didSelect(sectionController: LoadMoreSectionController) {
        fetch(nextPage: true)
    }

}
