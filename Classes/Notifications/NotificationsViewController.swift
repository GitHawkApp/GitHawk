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

    let selection = SegmentedControlModel(items: [Strings.all, Strings.unread])

    var allNotifications = [RepoNotifications]() {
        didSet {
            update()
        }
    }
    var filteredNotifications = [RepoNotifications]()

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
        navigationItem.title = NSLocalizedString("Notifications", comment: "")
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

        allNotifications = fakeNotifications(width: view.bounds.width)

//        requestNotifications(session: session, all: true) { result in
//            switch result {
//            case .success(let notifications):
//                self.repoNotifications = createRepoNotifications(
//                    containerWidth: self.view.bounds.width,
//                    notifications: notifications
//                )
//            case .failed:
//                print("failed")
//            }
//        }
    }

    // MARK: Private API

    fileprivate func update() {
        let unread = selection.items[selection.selectedIndex] == Strings.unread
        filteredNotifications = filter(repoNotifications: allNotifications, unread: unread)
        adapter.performUpdates(animated: true)
    }

}

extension NotificationsViewController: IGListAdapterDataSource {

    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        guard allNotifications.count > 0 else { return [] }
        return [selection] + filteredNotifications
    }

    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if object is SegmentedControlModel {
            let controller = SegmentedControlSectionController()
            controller.delegate = self
            return controller
        } else {
            return RepoNotificationsSectionController()
        }
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        let emptyView = EmptyView()
        emptyView.label.text = NSLocalizedString("Cannot load notifications", comment: "")
        return emptyView
    }

}

extension NotificationsViewController: SegmentedControlSectionControllerDelegate {

    func didChangeSelection(sectionController: SegmentedControlSectionController, model: SegmentedControlModel) {
        update()
    }
    
}
