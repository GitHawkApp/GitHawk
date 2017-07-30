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

    private let client: RepositoryClient
    private lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()
    private let selection = SegmentedControlModel.forRepository()
    private let loadMore = "loadMore" as ListDiffable
    
    init(client: GithubClient, repo: RepositoryLoadable) {
        self.client = RepositoryClient(githubClient: client, repo: repo)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feed.viewDidLoad()
        feed.adapter.dataSource = self
        title = client.repo.nameWithOwner
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        feed.viewWillLayoutSubviews(view: view)
    }
    
    // MARK: Data Loading/Paging
    
    private func update(dismissRefresh: Bool, animated: Bool = true) {
        feed.finishLoading(dismissRefresh: dismissRefresh, animated: animated)
    }
    
    func reload() {
        client.load(containerWidth: view.bounds.width) {
            self.update(dismissRefresh: true, animated: true)
        }
    }
    
    func loadNextPage() {
        if selection.issuesSelected {
            client.loadMoreIssues(containerWidth: view.bounds.width) {
                self.update(dismissRefresh: true, animated: false)
            }
        } else {
            client.loadMorePullRequests(containerWidth: view.bounds.width) {
                self.update(dismissRefresh: true, animated: false)
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
        
        if client.issues.count > 0, selection.issuesSelected {
            builder += client.issues as [ListDiffable]
            
            if client.issuesNextPage != nil {
                builder.append(loadMore)
            }
        } else if client.pullRequests.count > 0, !selection.issuesSelected {
            builder += client.pullRequests as [ListDiffable]
            
            if client.pullRequestsNextPage != nil {
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
        else if object is IssueSummaryModel { return RepositorySummarySectionController(client: client.githubClient, repo: client.repo) }
        
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
