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

class RepositoryIssuesViewController: BaseListViewController<NSString>, BaseListViewControllerDataSource, SearchBarSectionControllerDelegate {

    private var models = [ListDiffable]()
    private let repo: RepositoryDetails
    private let client: RepositoryClient
    private let type: RepositoryIssuesType
    private let searchKey: ListDiffable = "searchKey" as ListDiffable
    private var searchQuery: String = ""

    init(client: GithubClient, repo: RepositoryDetails, type: RepositoryIssuesType) {
        self.repo = repo
        self.client = RepositoryClient(githubClient: client, owner: repo.owner, name: repo.name)
        self.type = type

        super.init(
            emptyErrorMessage: NSLocalizedString("Cannot load issues.", comment: ""),
            dataSource: self
        )

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
        // set the frame in -viewDidLoad is required when working with TabMan
        feed.collectionView.frame = view.bounds
        if #available(iOS 11.0, *) {
            feed.collectionView.contentInsetAdjustmentBehavior = .never
        }
    }

    // MARK: Overrides

    override func fetch(page: NSString?) {
        let width = view.bounds.width
        let block = { [weak self] (result: Result<RepositoryClient.RepositoryPayload>) in
            switch result {
            case .error:
                self?.error(animated: true)
            case .success(let payload):
                if page != nil {
                    self?.models += payload.models as [ListDiffable]
                } else {
                    self?.models = payload.models
                }
                self?.update(page: payload.nextPage as NSString?, animated: true)
            }
        }

        switch type {
        case .issues: client.loadIssues(nextPage: page as String?, containerWidth: width, completion: block)
        case .pullRequests: client.loadPullRequests(nextPage: page as String?, containerWidth: width, completion: block)
        }
    }

    // MARK: SearchBarSectionControllerDelegate

    func didChangeSelection(sectionController: SearchBarSectionController, query: String) {
        filter(query: query.trimmingCharacters(in: .whitespacesAndNewlines), animated: true)
    }

    // MARK: BaseListViewControllerDataSource

    func headModels(listAdapter: ListAdapter) -> [ListDiffable] {
        return [searchKey]
    }

    func models(listAdapter: ListAdapter) -> [ListDiffable] {
        return models
    }

    func sectionController(model: Any, listAdapter: ListAdapter) -> ListSectionController {
        if let object = model as? ListDiffable, object === searchKey {
            return SearchBarSectionController(placeholder: Constants.Strings.search, delegate: self)
        }
        return RepositorySummarySectionController(client: client.githubClient, repo: repo)
    }

    func emptySectionController(listAdapter: ListAdapter) -> ListSectionController {
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
    }
}
