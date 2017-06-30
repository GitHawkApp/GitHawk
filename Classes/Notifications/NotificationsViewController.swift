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
NotificationClientListener {

    let client: NotificationClient
    let selection = SegmentedControlModel(items: [Strings.unread, Strings.all])
    var allNotifications = [NotificationViewModel]()
    var filteredNotifications = [NotificationViewModel]()
    let spinnerKey: ListDiffable = "spinnerKey" as ListDiffable
    let emptyKey: ListDiffable = "emptyKey" as ListDiffable

    lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()

    init(client: GithubClient) {
        self.client = NotificationClient(githubClient: client)
        super.init(nibName: nil, bundle: nil)
        self.client.add(listener: self)
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

    private func update(dismissRefresh: Bool, animated: Bool = true) {
        let unread = selection.items[selection.selectedIndex] == Strings.unread
        filteredNotifications = filter(
            notifications: allNotifications,
            optimisticReadIDs: client.optimisticReadIDs,
            unread: unread
        )
        feed.finishLoading(dismissRefresh: dismissRefresh, animated: animated)
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
        self.update(dismissRefresh: true, animated: animated)
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
        var objects: [ListDiffable] = [selection]

        if filteredNotifications.count == 0 {
            objects.append(emptyKey)
        } else {
            objects += filteredNotifications as [ListDiffable]
        }

        if feed.status == .loadingNext {
            objects.append(spinnerKey)
        }
        return objects
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let object = object as? ListDiffable else { fatalError("Object not diffable") }

        // 28 is the default height of UISegmentedControl
        let controlHeight = 28 + 2*Styles.Sizes.rowSpacing
        
        if object === spinnerKey { return SpinnerSectionController() }
        else if object === emptyKey { return NoNewNotificationsSectionController(topInset: controlHeight, topLayoutGuide: topLayoutGuide) }

        switch object {
        case is SegmentedControlModel: return SegmentedControlSectionController(delegate: self, height: controlHeight)
        case is NotificationViewModel: return NotificationsSectionController(client: client)
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
        update(dismissRefresh: false)
    }

    // MARK: FeedDelegate

    func loadFromNetwork(feed: Feed) {
        reload()
    }

    func loadNextPage(feed: Feed) -> Bool {
        print("would load page")
        return false
    }

    // MARK: NotificationClientListener

    func willMarkRead(client: NotificationClient, id: String, optimistic: Bool) {
        if optimistic {
            update(dismissRefresh: false, animated: true)
        }
    }

    func didFailToMarkRead(client: NotificationClient, id: String, optimistic: Bool) {
        StatusBar.showGenericError()
        if optimistic {
            update(dismissRefresh: false, animated: true)
        }
    }

}
