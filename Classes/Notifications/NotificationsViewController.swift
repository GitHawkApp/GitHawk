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

    let client: NotificationClient
    let selection = SegmentedControlModel(items: [Strings.unread, Strings.all])
    var allNotifications = [NotificationViewModel]()
    var filteredNotifications = [NotificationViewModel]()

    lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()

    init(client: GithubClient) {
        self.client = NotificationClient(githubClient: client)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        feed.viewDidLoad()
        feed.adapter.dataSource = self

        resetRightBarItem()
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

    func resetRightBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Mark All", comment: ""),
            style: .plain,
            target: self,
            action: #selector(NotificationsViewController.onMarkAll(sender:))
        )
    }

    func setRightBarItemSpinning() {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activity.startAnimating()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activity)
    }

    private func markAllRead() {
        self.setRightBarItemSpinning()
        self.client.markAllNotifications { _ in
            self.reload()
        }
    }

    @objc private func onMarkAll(sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: NSLocalizedString("Notifications", comment: ""),
            message: "Mark all notifications as read?",
            preferredStyle: .alert
        )
        let markAll = UIAlertAction(
            title: NSLocalizedString("Mark all", comment: ""),
            style: .default
        ) { _ in
            self.markAllRead()
        }
        alert.addAction(markAll)

        let cancel = UIAlertAction(title: Strings.cancel, style: .cancel)
        alert.addAction(cancel)

        alert.popoverPresentationController?.barButtonItem = sender
        present(alert, animated: true)
    }

    private func update(fromNetwork: Bool, animated: Bool = true) {
        let unread = selection.items[selection.selectedIndex] == Strings.unread
        filteredNotifications = filter(notifications: allNotifications, unread: unread)
        feed.finishLoading(fromNetwork: fromNetwork, animated: animated)
    }

    private func handle(result: NotificationClient.Result, append: Bool, animated: Bool) {
        // in case coming from "mark all" action
        self.resetRightBarItem()

        switch result {
        case .success(let notifications):
            let models = createNotificationViewModels(
                containerWidth: self.view.bounds.width,
                notifications: notifications
            )
            if append {
                self.allNotifications += models
            } else {
                self.allNotifications = models
            }
        case .failed:
            StatusBar.showNetworkError()
        }
        self.update(fromNetwork: true, animated: animated)
    }

    private func reload() {
        client.requestNotifications(all: true) { result in
            self.handle(result: result, append: false, animated: true)
        }
    }

    private func nextPage() {
        client.requestNotifications(all: true, nextPage: true) { result in
            self.handle(result: result, append: true, animated: false)
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
        case is NotificationViewModel: return RepoNotificationsSectionController(client: client.githubClient, delegate: self)
        default: fatalError("Unhandled object: \(object)")
        }
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        switch feed.status {
        case .idle:
            let emptyView = EmptyView()
            emptyView.label.text = NSLocalizedString("Cannot load notifications", comment: "")
            return emptyView
        case .loading, .loadingNext:
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

    func loadNextPage(feed: Feed) -> Bool {
        print("would load page")
        return false
    }

    // MARK: RepoNotificationsSectionControllerDelegate

    func didMarkRead(sectionController: RepoNotificationsSectionController) {
        // TODO
    }
    
}
