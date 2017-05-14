//
//  NotificationsViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

class NotificationsViewController: UIViewController {

    let session: GithubSession
    var repoNotifications = [RepoNotifications]() {
        didSet {
            adapter.performUpdates(animated: true)
        }
    }

    lazy var collectionView: UICollectionView = {
        let uicv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        uicv.backgroundColor = .white
        uicv.alwaysBounceVertical = true
        return uicv
    }()
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self)
    }()

    init(session: GithubSession) {
        self.session = session
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }

        adapter.collectionView = collectionView
        adapter.dataSource = self

        requestNotifications(session: session) { result in
            switch result {
            case .success(let notifications):
                self.repoNotifications = createRepoNotifications(
                    containerWidth: self.view.bounds.width,
                    notifications: notifications
                )
            case .failed:
                print("failed")
            }
        }
    }

}

extension NotificationsViewController: IGListAdapterDataSource {
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return repoNotifications
    }

    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return RepoNotificationsSectionController()
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }
    
}
