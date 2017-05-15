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
    let selection = SegmentedControlModel(items: [Strings.unread, Strings.all])
    var allNotifications = [RepoNotifications]()
    var filteredNotifications = [RepoNotifications]()

    lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()

    init(session: GithubSession) {
        self.session = session
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = NSLocalizedString("Notifications", comment: "")
        navigationItem.title = title
        navigationController?.tabBarItem.title = title
        navigationController?.tabBarItem.image = UIImage(named: "bell")

        feed.viewDidLoad()
        feed.adapter.dataSource = self
    }

    // MARK: Private API

    fileprivate func update(fromNetwork: Bool) {
        let unread = selection.items[selection.selectedIndex] == Strings.unread
        filteredNotifications = filter(repoNotifications: allNotifications, unread: unread)
        feed.finishLoading(fromNetwork: fromNetwork)
    }

    fileprivate func reload() {
        requestNotifications(session: session, all: true) { result in
            switch result {
            case .success(let notifications):
                self.allNotifications = createRepoNotifications(
                    containerWidth: self.view.bounds.width,
                    notifications: notifications
                )
            case .failed:
                print("failed")
            }
            self.update(fromNetwork: true)
        }
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
        update(fromNetwork: false)
    }
    
}

extension NotificationsViewController: FeedDelegate {

    func loadFromNetwork(feed: Feed) {
        reload()
    }

}
