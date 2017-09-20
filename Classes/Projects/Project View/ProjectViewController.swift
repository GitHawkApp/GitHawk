//
//  ProjectViewController.swift
//  Freetime
//
//  Created by Sherlock, James on 19/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

final class ProjectViewController: UIViewController, FeedDelegate, ListAdapterDataSource {
    
    private let client: GithubClient
    private let repository: RepositoryDetails
    private let project: Project
    
    private lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()
    
    // MARK: - Initialiser
    
    init(client: GithubClient, repository: RepositoryDetails, project: Project) {
        self.client = client
        self.repository = repository
        self.project = project
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feed.collectionView.refreshControl = nil
        feed.viewDidLoad()
        feed.adapter.dataSource = self
        feed.collectionView.alwaysBounceVertical = false
        feed.collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        if let layout = feed.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        title = project.name
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        feed.viewWillLayoutSubviews(view: view)
    }
    
    // MARK: - Loading
    
    private func update() {
        feed.finishLoading(dismissRefresh: true, animated: true, completion: nil)
    }
    
    private func reload() {
        project.loadDetails(client: client) { [weak self] error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self?.update()
        }
    }
    
    // MARK: - FeedDelegate
    
    func loadFromNetwork(feed: Feed) {
        reload()
    }
    
    func loadNextPage(feed: Feed) -> Bool {
        return false
    }
    
    // MARK: - ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return project.details?.columns ?? []
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ProjectColumnSectionController(client: client, repo: repository, topLayoutGuide: topLayoutGuide, bottomLayoutGuide: bottomLayoutGuide)
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
