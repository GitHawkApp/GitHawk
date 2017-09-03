//
//  RepositoryViewController.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

struct RepositoryDetails {
    let owner: String
    let name: String
    let hasIssuesEnabled: Bool
}

class RepositoryViewController: UIViewController,
    FeedDelegate,
    ListAdapterDataSource,
    SegmentedControlSectionControllerDelegate,
    SearchLoadMoreSectionControllerDelegate,
PrimaryViewController {

    private let repo: RepositoryDetails
    private let client: RepositoryClient
    private lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()
    private let selection: SegmentedControlModel

    private let noIssuesResultsKey = "noIssuesResultsKey" as ListDiffable
    private let noPullRequestsResultsKey = "noPullRequestsResultsKey" as ListDiffable
    private let loadMore = "loadMore" as ListDiffable

    private var issues = [IssueSummaryModel]()
    private var issuesNextPage: String?
    private var pullRequests = [IssueSummaryModel]()
    private var pullRequestsNextPage: String?

    init(client: GithubClient, repo: RepositoryDetails) {
        self.repo = repo
        self.client = RepositoryClient(githubClient: client, owner: repo.owner, name: repo.name)
        self.selection = SegmentedControlModel.forRepository(repo.hasIssuesEnabled)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        feed.viewDidLoad()
        feed.adapter.dataSource = self
        title = "\(repo.owner)/\(repo.name)"
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        feed.viewWillLayoutSubviews(view: view)
    }

    // MARK: Data Loading/Paging

    private func update(dismissRefresh: Bool, animated: Bool) {
        feed.finishLoading(dismissRefresh: dismissRefresh, animated: animated)
    }

    func reload() {
        client.load(containerWidth: view.bounds.width) { result in
            switch result {
            case .error: break
            case .success(let payload):
                self.issues = payload.issues.models
                self.issuesNextPage = payload.issues.nextPage
                self.pullRequests = payload.pullRequests.models
                self.pullRequestsNextPage = payload.pullRequests.nextPage
                self.update(dismissRefresh: true, animated: true)
            }
        }
    }

    func loadNextPage() {
        let width = view.bounds.width

        if selection.issuesSelected {
            client.loadMoreIssues(nextPage: issuesNextPage, containerWidth: width, completion: { result in
                switch result {
                case .error: break
                case .success(let payload):
                    self.issues += payload.models
                    self.issuesNextPage = payload.nextPage
                    self.update(dismissRefresh: true, animated: false)
                }
            })
        } else {
            client.loadMorePullRequests(nextPage: issuesNextPage, containerWidth: width, completion: { result in
                switch result {
                case .error: break
                case .success(let payload):
                    self.pullRequests += payload.models
                    self.pullRequestsNextPage = payload.nextPage
                    self.update(dismissRefresh: true, animated: false)
                }
            })
        }
    }

    // MARK: FeedDelegate

    func loadFromNetwork(feed: Feed) {
        reload()
    }

    func loadNextPage(feed: Feed) -> Bool {
        return false
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var builder = [ListDiffable]()

        if repo.hasIssuesEnabled {
            builder.append(selection)
        }

        if selection.issuesSelected {
            if issues.count > 0 {
                builder += issues as [ListDiffable]
                if issuesNextPage != nil {
                    builder.append(loadMore)
                }
            } else {
                builder.append(noIssuesResultsKey)
            }
        } else if !selection.issuesSelected {
            if pullRequests.count > 0 {
                builder += pullRequests as [ListDiffable]
                if pullRequestsNextPage != nil {
                    builder.append(loadMore)
                }
            } else {
                builder.append(noPullRequestsResultsKey)
            }
        }

        return builder
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let object = object as? ListDiffable else { fatalError("Object does not conform to ListDiffable") }

        // 28 is the default height of UISegmentedControl
        let controlHeight = 28 + 2*Styles.Sizes.rowSpacing

        if object === noIssuesResultsKey {
            return RepositoryEmptyResultsSectionController(topInset: controlHeight, topLayoutGuide: topLayoutGuide, type: .issues)
        } else if object === noPullRequestsResultsKey {
            return RepositoryEmptyResultsSectionController(topInset: controlHeight, topLayoutGuide: topLayoutGuide, type: .pullRequests)
        } else if object === selection {
            return SegmentedControlSectionController(delegate: self, height: controlHeight)
        } else if object === loadMore {
            return SearchLoadMoreSectionController(delegate: self)
        } else if object is IssueSummaryModel {
            return RepositorySummarySectionController(client: client.githubClient, repo: repo)
        }

        fatalError("Could not find section controller for object")
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

    // MARK: SegmentedControlSectionControllerDelegate

    func didChangeSelection(sectionController: SegmentedControlSectionController, model: SegmentedControlModel) {
        update(dismissRefresh: false)
    }

    // MARK: SearchLoadMoreSectionControllerDelegate

    func didSelect(sectionController: SearchLoadMoreSectionController) {
        loadNextPage()
    }
}
