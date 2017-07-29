//
//  RepositoryViewController.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

class RepositoryViewController: UIViewController, FeedDelegate, ListAdapterDataSource {

    private let repo: RepositoryLoadable
    private let client: GithubClient
    private lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()
    private var issues = [IssueSummaryType]()
    private var issuesNextPage: String?
    
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
        switch resultType {
        case .error:
            print("😞 Something went wrong, here's some pizza 🍕")
            break
        case .success(let nextPage, let results):
            if append {
                self.issues += results
            } else {
                self.issues = results
            }
            
            self.issuesNextPage = nextPage
            self.update(dismissRefresh: !append, animated: animated)
            break
        }
    }
    
    func reload() {
        client.load(repo: repo, containerWidth: view.bounds.width) { [weak self] resultType in
            self?.handle(resultType: resultType, append: false, animated: true)
        }
    }
    
    func loadNextPage() {
        guard let nextPage = issuesNextPage else { return }
        client.load(repo: repo, before: nextPage, containerWidth: view.bounds.width) { [weak self] resultType in
            self?.handle(resultType: resultType, append: true, animated: false)
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
        
        if issues.count > 0 {
            builder += issues as [ListDiffable]
        }
        
        return builder
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let object = object as? ListDiffable else { fatalError("Object does not conform to ListDiffable") }
        
        if object is IssueSummaryType { return RepositorySummarySectionController(client: client, repo: repo) }
        
        fatalError("Could not find section controller for object")
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
