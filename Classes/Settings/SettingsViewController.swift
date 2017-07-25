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

final class SettingsViewController: UIViewController, ListAdapterDataSource {

    // injected
    private let sessionManager: GithubSessionManager
    weak var rootNavigationManager: RootNavigationManager? = nil

    private lazy var adapter: ListAdapter = { ListAdapter(updater: ListAdapterUpdater(), viewController: self) }()

    private let signoutKey = "signout" as ListDiffable
    private let reportKey = "report" as ListDiffable
    private let accessKey = "access" as ListDiffable
    private let sourceKey = "source" as ListDiffable
    private let versionInfoKey = "versionInfo" as ListDiffable

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.alwaysBounceVertical = true
        view.contentInset = UIEdgeInsets(
            top: Styles.Sizes.tableSectionSpacing,
            left: 0,
            bottom: Styles.Sizes.tableSectionSpacing,
            right: 0
        )
        view.backgroundColor = Styles.Colors.background
        return view
    }()

    init(
        sessionManager: GithubSessionManager,
        rootNavigationManager: RootNavigationManager
        ) {
        self.sessionManager = sessionManager
        self.rootNavigationManager = rootNavigationManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.dataSource = self
        adapter.collectionView = collectionView

        view.addSubview(collectionView)

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(SettingsViewController.onDone)
        )
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let bounds = view.bounds
        if collectionView.frame != bounds {
            collectionView.frame = bounds
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(collectionView)
    }
    
    // MARK: Accessibility
    
    override func accessibilityPerformEscape() -> Bool {
        onDone()
        return true
    }

    // MARK: Private API

    @objc private func onDone() {
        dismiss(animated: true)
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [
            accessKey,
            reportKey,
            sourceKey,
            signoutKey,
            versionInfoKey
        ]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let object = object as? ListDiffable else { fatalError("Object not diffable") }
        if object === signoutKey {
            return SettingsSignoutSectionController(sessionManager: sessionManager)
        } else if object === reportKey {
            return SettingsReportSectionController()
        } else if object === accessKey {
            return SettingsAccessSectionController()
        } else if object === versionInfoKey {
            return SettingsVersionInfoSectionController()
        } else if object === sourceKey {
            return SettingsSourceSectionController()
        }
        fatalError("Unhandled object: \(object)")
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }

}
