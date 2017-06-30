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

class NotificationsViewController: UIViewController,
    ListAdapterDataSource,
    SegmentedControlSectionControllerDelegate,
    FeedDelegate,
RepoNotificationsSectionControllerDelegate {

    let client: GithubClient
    let selection = SegmentedControlModel(items: [Strings.unread, Strings.all])
    var allNotifications = [NotificationViewModel]()
    var filteredNotifications = [NotificationViewModel]()

    lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()

    init(client: GithubClient) {
        self.client = client
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        feed.viewDidLoad()
        feed.adapter.dataSource = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Mark All", comment: ""),
            style: .plain,
            target: self,
            action: #selector(NotificationsViewController.onMarkAll(sender:))
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(feed.collectionView)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        feed.viewWillTransition(to: size, with: coordinator)
    }

    // MARK: Private API

    @objc private func onMarkAll(sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: NSLocalizedString("Notifications", comment: ""),
            message: "Mark all notifications as read?",
            preferredStyle: .alert
        )
        let ok = UIAlertAction(
            title: NSLocalizedString("Mark all", comment: ""),
            style: .default,
            handler: nil
        )
        alert.addAction(ok)

        let cancel = UIAlertAction(title: Strings.cancel, style: .cancel)
        alert.addAction(cancel)

        alert.popoverPresentationController?.barButtonItem = sender
        present(alert, animated: true)
    }

    private func update(fromNetwork: Bool) {
        let unread = selection.items[selection.selectedIndex] == Strings.unread
        filteredNotifications = filter(notifications: allNotifications, unread: unread)
        feed.finishLoading(fromNetwork: fromNetwork)
    }

    private func reload() {
        client.requestNotifications(all: true) { result in
            switch result {
            case .success(let notifications):
                self.allNotifications = createNotificationViewModels(
                    containerWidth: self.view.bounds.width,
                    notifications: notifications
                )
            case .failed:
                StatusBar.showNetworkError()
            }
            self.update(fromNetwork: true)
        }
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        guard allNotifications.count > 0 else { return [] }
        return [selection] + filteredNotifications
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is SegmentedControlModel: return SegmentedControlSectionController(delegate: self)
        case is NotificationViewModel: return RepoNotificationsSectionController(client: client, delegate: self)
        default: fatalError("Unhandled object: \(object)")
        }
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        switch feed.status {
        case .idle:
            let emptyView = EmptyView()
            emptyView.label.text = NSLocalizedString("Cannot load notifications", comment: "")
            return emptyView
        case .loading:
            return nil
        }
    }

    // MARK: SegmentedControlSectionControllerDelegate

    func didChangeSelection(sectionController: SegmentedControlSectionController, model: SegmentedControlModel) {
        update(fromNetwork: false)
    }

    // MARK: FeedDelegate
    
    func loadFromNetwork(feed: Feed) {
        reload()
    }

    // MARK: RepoNotificationsSectionControllerDelegate

    func didMarkRead(sectionController: RepoNotificationsSectionController) {
        // TODO
    }
    
}
