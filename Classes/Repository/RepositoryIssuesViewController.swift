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
                self?.update(
                    models: payload.models,
                    page: payload.nextPage as NSString?,
                    append: page != nil,
                    animated: true
                )
            }
        }

        switch type {
        case .issues: client.loadIssues(nextPage: page as String?, containerWidth: width, completion: block)
        case .pullRequests: client.loadPullRequests(nextPage: page as String?, containerWidth: width, completion: block)
        }
    }

    override func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        let allObjects = super.objects(for: listAdapter)
        switch type {
        case .issues: return filterIssues(allObjects, self.searchQuery)
        case .pullRequests: return filterIssues(allObjects, self.searchQuery)
        }
    }

    // MARK: SearchBarSectionControllerDelegate

    func didChangeSelection(sectionController: SearchBarSectionController, query: String) {
        self.searchQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        self.performUpdate()
    }

    // MARK: BaseListViewControllerDataSource

    func headModels(listAdapter: ListAdapter) -> [ListDiffable] {
        return [searchKey]
    }

    func sectionController(model: Any, listAdapter: ListAdapter) -> ListSectionController {
        if let object = model as? ListDiffable, object === searchKey {
            let searchBarHeight = 44 + 2*Styles.Sizes.rowSpacing
            return SearchBarSectionController(placeholder: NSLocalizedString("Search", comment: ""), delegate: self, height: searchBarHeight)
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
