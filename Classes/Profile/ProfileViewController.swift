//
//  ProfileViewController.swift
//  Freetime
//
//  Created by B_Litwin on 8/15/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import Squawk

final class ProfileViewController: UIViewController, ListAdapterDataSource {
    private let client: GithubClient
    private var model: UserProfileModel?
    private var userLogin: String
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: ListCollectionViewLayout.basic())
        view.backgroundColor =  Styles.Colors.background
        return view
    }()
    
    private lazy var adapter: ListAdapter = {
        ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    init(client: GithubClient, userLogin: String) {
        self.client = client
        self.userLogin = userLogin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        adapter.collectionView = collectionView
        adapter.dataSource = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        fetchData()
    }
    
    private func fetchData() {
        let query = UserQuery(login: client.userSession?.username ?? "" )
        client.client.query(query, result: { $0 }) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .failure(let error):
                Squawk.showError(message: "Could not load user profile for \(strongSelf.userLogin)")
                break
            case .success(let data):
                guard let user = data.user else { return }
                strongSelf.model = UserProfileModel(user)
                strongSelf.adapter.reloadData()
            }
        }
    }
    
    // MARK: ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        guard let model = model else { return [] }
        return [model]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is UserProfileModel:
            return ProfileOverviewSectionController()
        default:
            fatalError("Unsupported model \(object)")
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return EmptyLoadingView()
    }
    
}
