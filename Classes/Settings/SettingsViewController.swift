//
//  SettingsViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

final class SettingsViewController: UIViewController {

    // injected
    fileprivate let sessionManager: GithubSessionManager
    weak var rootNavigationManager: RootNavigationManager? = nil

    fileprivate lazy var adapter: IGListAdapter = { IGListAdapter(updater: IGListAdapterUpdater(), viewController: self) }()

    fileprivate let addKey = "add"
    fileprivate let signoutKey = "signout"
    fileprivate lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.alwaysBounceVertical = true
        view.contentInset = UIEdgeInsets(
            top: Styles.Sizes.tableSectionSpacing,
            left: 0,
            bottom: Styles.Sizes.tableSectionSpacing,
            right: 0
        )
        view.backgroundColor = Styles.Colors.Gray.lighter
        return view
    }()

    init(
        sessionManager: GithubSessionManager,
        rootNavigationManager: RootNavigationManager
        ) {
        self.sessionManager = sessionManager
        self.rootNavigationManager = rootNavigationManager
        super.init(nibName: nil, bundle: nil)
        sessionManager.addListener(listener: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.dataSource = self
        adapter.collectionView = collectionView

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }

}

extension SettingsViewController: IGListAdapterDataSource {

    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return [
            addKey as IGListDiffable,
            sessionManager,
            signoutKey as IGListDiffable
        ]
    }

    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if let str = object as? String, str == addKey, let mgr = rootNavigationManager {
            return SettingsAddAccountSectionController(rootNavigationManager: mgr)
        } else if let str = object as? String, str == signoutKey {
            return SettingsSignoutSectionController(sessionManager: sessionManager)
        } else {
            return SettingsUsersSectionController()
        }
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }

}

extension SettingsViewController: GithubSessionListener {

    func didFocus(manager: GithubSessionManager, userSession: GithubUserSession) {
        adapter.performUpdates(animated: false)
    }

    func didRemove(manager: GithubSessionManager, userSessions: [GithubUserSession], result: GithubSessionResult) {
        adapter.performUpdates(animated: false)
    }

}
