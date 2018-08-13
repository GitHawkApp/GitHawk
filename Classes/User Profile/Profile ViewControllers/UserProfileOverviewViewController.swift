//
//  UserProfileOverviewViewController.swift
//  Freetime
//
//  Created by B_Litwin on 8/12/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import Apollo
import SnapKit
import IGListKit

protocol SetsTabmanTitlesDelegate: class {
    func setTitles(userRepoCount: Int, starredReposCount: Int)
}

class UserProfileOverviewViewController:
    UIViewController,
    ListAdapterDataSource,
    SearchResultSectionControllerDelegate
{
    
    
    private let client: UserProfileClient
    private let gitHubClient: GithubClient
    private var userProfileModel: UserProfileModel?
    weak var setTabmanTitlesDelegate: SetsTabmanTitlesDelegate?
    
    private lazy var adapter: ListAdapter = { ListAdapter(updater: ListAdapterUpdater(),
                                                          viewController: self) }()
    
    private let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: ListCollectionViewLayout.basic())
        view.alwaysBounceVertical = true
        view.backgroundColor = Styles.Colors.background
        return view
    }()

    init(client: UserProfileClient,
         gitHubClient: GithubClient)
    {
        self.client = client
        self.gitHubClient = gitHubClient
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        adapter.dataSource = self
        adapter.collectionView = collectionView
        view.addSubview(collectionView)
        collectionView.frame = view.bounds

        client.fetchUserProfileInfo() { [weak self] result in
            self?.handle(result: result)
        }
    }
    
    func handle(result: GithubClient.UserProfileResultType) {
        //ALL TODOS
        switch result {
        case .error(let error):
            //TODO
            break
            
        case .success(let userProfile):
            self.userProfileModel = userProfile
            setTabmanTitlesDelegate?.setTitles(userRepoCount: userProfile.repositoriesCount,
                                               starredReposCount: userProfile.starredReposCount)
            
            adapter.reloadData()
        }
        
    }
    
    //MARK: LIstAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        guard let model = userProfileModel else { return [] }
        var data = [ListDiffable]()
        
        if !model.pinnedRepositories.isEmpty {
            let header = ProfileHeaderKey(title: "Pinned Repositories")
            let pinnedRepos = model.pinnedRepositories.map { $0.searchRepoResults() }
            data.append(header)
            pinnedRepos.forEach { data.append($0) }
        }
        
        let followersHeader = ProfileHeaderKey(title: "Followers (\(model.followersCount))")
        data.append(followersHeader)
        
        let followingHeader = ProfileHeaderKey(title: "Following (\(model.followingCount))")
        data.append(followingHeader)
        
        return data
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {

        switch object {
        case is SearchRepoResult: return SearchResultSectionController(client: gitHubClient, delegate: self)
        case is ProfileHeaderKey: return ProfileHeaderSectionController()
            
        default:
            fatalError("Unsupported object")
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return SearchLoadingView()
    }
    
    // MARK: SearchResultSectionControllerDelegate
    
    func didSelect(sectionController: SearchResultSectionController, repo: RepositoryDetails) {
        //TODO
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}









