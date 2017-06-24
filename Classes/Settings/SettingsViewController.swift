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

final class SettingsViewController: UIViewController, ListAdapterDataSource, GithubSessionListener {

    // injected
    fileprivate let sessionManager: GithubSessionManager
    weak var rootNavigationManager: RootNavigationManager? = nil

    fileprivate lazy var adapter: ListAdapter = { ListAdapter(updater: ListAdapterUpdater(), viewController: self) }()

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
        view.backgroundColor = Styles.Colors.Gray.lighter.color
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

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [
            addKey as ListDiffable,
            sessionManager,
            signoutKey as ListDiffable
        ]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let str = object as? String, str == addKey, let mgr = rootNavigationManager {
            return SettingsAddAccountSectionController(rootNavigationManager: mgr)
        } else if let str = object as? String, str == signoutKey {
            return SettingsSignoutSectionController(sessionManager: sessionManager)
        } else {
            return SettingsUsersSectionController()
        }
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }

    // MARK: GithubSessionListener

    func didFocus(manager: GithubSessionManager, userSession: GithubUserSession) {
        adapter.performUpdates(animated: false)
    }

    func didRemove(manager: GithubSessionManager, userSessions: [GithubUserSession], result: GithubSessionResult) {
        adapter.performUpdates(animated: false)
    }
    
    func didCancel(manager: GithubSessionManager) {
        // No-op; no updates needed
    }

}
