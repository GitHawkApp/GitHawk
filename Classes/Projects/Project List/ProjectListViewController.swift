//
//  ProjectListViewController.swift
//  Freetime
//
//  Created by Sherlock, James on 18/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class ProjectListViewController: UIViewController,
    FeedDelegate,
    ListAdapterDataSource,
    LoadMoreSectionControllerDelegate {

    private let client: GithubClient
    private let repository: RepositoryDetails
    
    private lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()
    private var projects: [Project]?
    private var nextPageToken: String?
    private let loadMore = "loadMore" as ListDiffable
    private var errorOnLoad = false
    
    // MARK: - Initialiser
    
    init(client: GithubClient, repository: RepositoryDetails) {
        self.client = client
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feed.viewDidLoad()
        feed.adapter.dataSource = self
        title = NSLocalizedString("Projects", comment: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(collectionView: feed.collectionView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        feed.viewWillLayoutSubviews(view: view)
    }
    
    // MARK: - Loading
    
    private func update() {
        feed.finishLoading(dismissRefresh: true, animated: true, completion: nil)
    }
    
    private func reload(loadNext: Bool = false) {
        let nextPage = loadNext ? nextPageToken : nil
        client.loadProjects(for: repository, containerWidth: view.bounds.width, nextPage: nextPage) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .error(let error):
                if strongSelf.projects == nil {
                    strongSelf.errorOnLoad = true
                }
                
                print(error?.localizedDescription ?? "No Error Description")
            case .success(let payload):
                strongSelf.nextPageToken = payload.nextPage
                
                if strongSelf.projects != nil {
                    strongSelf.projects?.append(contentsOf: payload.projects)
                } else {
                    strongSelf.projects = payload.projects
                }
                
                strongSelf.update()
            }
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
        var builder: [ListDiffable] = projects ?? []
        
        if nextPageToken != nil {
            builder.append(loadMore)
        }
        
        return builder
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let object = object as? ListDiffable else { fatalError("Unexpected Object") }
        
        if object === loadMore { return LoadMoreSectionController(delegate: self) }
        else if object is Project { return ProjectSummarySectionController(client: client, repo: repository) }
        
        fatalError("Unhandled Item Type")
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        switch feed.status {
        case .idle:
            let emptyView = EmptyView()
            
            if errorOnLoad {
                emptyView.label.text = NSLocalizedString("Error loading projects", comment: "")
            } else {
                emptyView.label.text = NSLocalizedString("No projects were found!", comment: "")
            }
            
            return emptyView
        case .loading, .loadingNext:
            return nil
        }
    }
    
    // MARK: LoadMoreSectionControllerDelegate
    
    func didSelect(sectionController: LoadMoreSectionController) {
        reload(loadNext: true)
    }
    
}
