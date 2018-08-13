//
//  BaseUserRepositoryViewController.swift
//  Freetime
//
//  Created by B_Litwin on 8/12/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

import IGListKit
import UIKit
import Apollo


typealias RepoContainer = SearchRepoResult

private extension RepositoryFragmentType {
    func convertToSearchRepoResult() -> SearchRepoResult {
        return SearchRepoResult(id: id,
                                owner: ownerLogin,
                                name: name,
                                description: description ?? "",
                                stars: starsCount,
                                hasIssuesEnabled: hasIssuesEnabled,
                                primaryLanguage: primaryGitHubLanguage,
                                defaultBranch: fragmentDefaultBranch)
    }
}



class UserProfileRepositoriesViewController: UIViewController, ListAdapterDataSource
{
    private let client: UserProfileClient
    private let gitHubClient: GithubClient
    private let tab: Tab
    private var repositories = [RepoContainer]()
    private var page: String?
    
    enum Tab {
        case userRepos
        case starredRepos
    }
    
    private lazy var adapter: ListAdapter = { ListAdapter(updater: ListAdapterUpdater(),
                                                          viewController: self) }()
    
    private let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: ListCollectionViewLayout.basic())
        view.alwaysBounceVertical = true
        view.backgroundColor = Styles.Colors.background
        return view
    }()
    
    init(client: UserProfileClient, gitHubClient: GithubClient, tab: Tab) {
        self.client = client
        self.gitHubClient = gitHubClient
        self.tab = tab
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        adapter.dataSource = self
        adapter.collectionView = collectionView
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        fetchData()
    }
    
    override func viewWillLayoutSubviews() {
        if view.bounds != collectionView.frame {
            collectionView.frame = view.bounds
            collectionView.collectionViewLayout.invalidateForOrientationChange()
        }
    }
    
    func fetchData() {

        switch tab {
        case .userRepos:
            client.fetchUserRepositories { [weak self] results in
                self?.handle(resultType: results, animated: false)
            }
            
        case .starredRepos:
            client.fetchStarredRepositories { [weak self] results in
                self?.handle(resultType: results, animated: false)
            }
        }
    }
    
    func handle(resultType: GithubClient.RepositoryFragmentsResultType, animated: Bool) {
        switch resultType {
        case let .error(error) where isCancellationError(error):
            return
        case .error:
            //todo: handle error
            break
            
        case .success(let page, let results):
            self.page = page
            repositories += results.map {
                 $0.convertToSearchRepoResult()
            }
        }
        adapter.reloadData()
    }
    
    //MARK: LIstAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return repositories
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        return SearchResultSectionController(client: gitHubClient,
                                             delegate: self)
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return SearchLoadingView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserProfileRepositoriesViewController: SearchResultSectionControllerDelegate {
    func didSelect(sectionController: SearchResultSectionController, repo: RepositoryDetails) {
        // TODO
    }
}








