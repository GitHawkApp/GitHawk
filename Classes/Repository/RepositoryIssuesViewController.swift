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

class RepositoryIssuesViewController: BaseListViewController<NSString>,
BaseListViewControllerDataSource,
SearchBarSectionControllerDelegate {

    private var models = [ListDiffable]()
    private let repo: RepositoryDetails
    private let client: RepositoryClient
    private let type: RepositoryIssuesType
    private let searchKey: ListDiffable = "searchKey" as ListDiffable
    private let debouncer = Debouncer()
    private var previousSearchString = "is:open"

    init(client: GithubClient, repo: RepositoryDetails, type: RepositoryIssuesType) {
        self.repo = repo
        self.client = RepositoryClient(githubClient: client, owner: repo.owner, name: repo.name)
        self.type = type

        super.init(
            emptyErrorMessage: NSLocalizedString("Cannot load issues.", comment: "")
        )
        
        self.dataSource = self

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

        makeBackBarItemEmpty()

        // set the frame in -viewDidLoad is required when working with TabMan
        feed.collectionView.frame = view.bounds
        feed.collectionView.contentInsetAdjustmentBehavior = .never
    }

    // MARK: Overrides

    override func fetch(page: NSString?) {
        client.searchIssues(
            query: fullQueryString,
            containerWidth: view.bounds.width
        ) { [weak self] (result: Result<RepositoryClient.RepositoryPayload>) in
            switch result {
            case .error:
                self?.error(animated: trueUnlessReduceMotionEnabled)
            case .success(let payload):
                if page != nil {
                    self?.models += payload.models as [ListDiffable]
                } else {
                    self?.models = payload.models
                }
                self?.update(page: payload.nextPage as NSString?, animated: trueUnlessReduceMotionEnabled)
            }
        }
    }

    // MARK: SearchBarSectionControllerDelegate

    func didChangeSelection(sectionController: SearchBarSectionController, query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard previousSearchString != trimmed else { return }
        previousSearchString = trimmed
        debouncer.action = { [weak self] in self?.fetch(page: nil) }
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
            return SearchBarSectionController(
                placeholder: Constants.Strings.search,
                delegate: self,
                query: previousSearchString
            )
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
            layoutInsets: view.safeAreaInsets,
            type: empty
        )
    }

    // MARK: Private API

    var fullQueryString: String {
        let typeQuery: String
        switch type {
        case .issues: typeQuery = "is:issue"
        case .pullRequests: typeQuery = "is:pr"
        }
        return "repo:\(repo.owner)/\(repo.name) \(typeQuery) \(previousSearchString)"
    }

}
