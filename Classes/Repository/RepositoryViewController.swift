//
//  RepositoryViewController.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

class RepositoryViewController: UIViewController,
                                FeedDelegate,
                                ListAdapterDataSource,
                                SegmentedControlSectionControllerDelegate,
                                SearchLoadMoreSectionControllerDelegate {

    private let repo: RepositoryLoadable
    private let client: GithubClient
    private lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()
    private let selection = SegmentedControlModel.forRepository()
    private let loadMore = "loadMore" as ListDiffable
    private var firstLoad = true
    
    private var issues = [IssueSummaryModel]()
    private var issuesNextPage: String?
    
    private var pullRequests = [IssueSummaryModel]()
    private var pullRequestsNextPage: String?
    
    init(client: GithubClient, repo: RepositoryLoadable) {
        self.repo = repo
        self.client = client
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feed.viewDidLoad()
        feed.adapter.dataSource = self
        title = repo.nameWithOwner
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        feed.viewWillLayoutSubviews(view: view)
    }
    
    // MARK: Data Loading/Paging
    
    private func update(dismissRefresh: Bool, animated: Bool = true) {
        feed.finishLoading(dismissRefresh: dismissRefresh, animated: animated)
    }
    
    private func handle(resultType: GithubClient.RepoLoadResultType, append: Bool, animated: Bool) {
        firstLoad = false
        
        switch resultType {
        case .error:
            print("😞 Something went wrong, here's some pizza 🍕")
            break
        case .success(let payload):
            if append {
                self.issues += payload.issues ?? []
                self.pullRequests += payload.pullRequests ?? []
            } else {
                self.issues = payload.issues ?? []
                self.pullRequests = payload.pullRequests ?? []
            }
            
            self.issuesNextPage = payload.issuesNextPage
            self.pullRequestsNextPage = payload.pullRequestsNextPage
            self.update(dismissRefresh: !append, animated: animated)
            break
        }
    }
    
    func reload() {
        client.load(
            repo: repo,
            includeIssues: firstLoad ? true : selection.issuesSelected,
            includePullRequests: firstLoad ? true : !selection.issuesSelected,
            containerWidth: view.bounds.width
        ) { [weak self] resultType in
            self?.handle(resultType: resultType, append: false, animated: true)
        }
    }
    
    func loadNextPage() {
        if let nextPage = issuesNextPage, selection.issuesSelected {
            client.load(repo: repo, before: nextPage, includePullRequests: false, containerWidth: view.bounds.width) {
                [weak self] resultType in
                self?.handle(resultType: resultType, append: true, animated: false)
            }
        } else if let nextPage = pullRequestsNextPage, !selection.issuesSelected {
            client.load(repo: repo, before: nextPage, includeIssues: false, containerWidth: view.bounds.width) {
                [weak self] resultType in
                self?.handle(resultType: resultType, append: true, animated: false)
            }
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
        var builder: [ListDiffable] = [selection]
        
        if issues.count > 0, selection.issuesSelected {
            builder += issues as [ListDiffable]
            
            if issuesNextPage != nil {
                builder.append(loadMore)
            }
        } else if pullRequests.count > 0, !selection.issuesSelected {
            builder += pullRequests as [ListDiffable]
            
            if pullRequestsNextPage != nil {
                builder.append(loadMore)
            }
        }
        
        return builder
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let object = object as? ListDiffable else { fatalError("Object does not conform to ListDiffable") }
        
        // 28 is the default height of UISegmentedControl
        let controlHeight = 28 + 2*Styles.Sizes.rowSpacing
        
        if object === selection { return SegmentedControlSectionController(delegate: self, height: controlHeight) }
        else if object === loadMore { return SearchLoadMoreSectionController(delegate: self) }
        else if object is IssueSummaryModel { return RepositorySummarySectionController(client: client, repo: repo) }
        
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
