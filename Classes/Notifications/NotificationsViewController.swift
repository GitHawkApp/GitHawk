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
    NotificationClientListener,
    NotificationNextPageSectionControllerDelegate,
FeedSelectionProviding,
ForegroundHandlerDelegate {

    private let client: NotificationClient
    private let selection = SegmentedControlModel.forNotifications()
    private let emptyKey: ListDiffable = "emptyKey" as ListDiffable
    private lazy var feed: Feed = { Feed(viewController: self, delegate: self) }()
    private var page: NSNumber? = nil
    private var hasError = false
    private let dataSource = NotificationsDataSource()
    private let foreground = ForegroundHandler(threshold: 5 * 60)

    init(client: GithubClient) {
        self.client = NotificationClient(githubClient: client)
        super.init(nibName: nil, bundle: nil)
        self.client.add(listener: self)
        self.foreground.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.warm(width: view.bounds.width)

        feed.viewDidLoad()
        feed.adapter.dataSource = self

        resetRightBarItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rz_smoothlyDeselectRows(collectionView: feed.collectionView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        feed.viewWillLayoutSubviews(view: view)
    }

    // MARK: Private API

    func resetRightBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Mark All", comment: ""),
            style: .plain,
            target: self,
            action: #selector(NotificationsViewController.onMarkAll(sender:))
        )
        updateUnreadState()
    }

    private func updateUnreadState() {
        let unreadCount = dataSource.unreadNotifications.count
        navigationItem.rightBarButtonItem?.isEnabled = unreadCount > 0
        BadgeNotifications.update(count: unreadCount)
    }

    func setRightBarItemSpinning() {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activity.startAnimating()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activity)
    }

    private func markAllRead() {
        self.setRightBarItemSpinning()
        self.client.markAllNotifications { success in
            let generator = UINotificationFeedbackGenerator()
            if success {
                generator.notificationOccurred(.success)

                // clear all badges
                BadgeNotifications.update(count: 0)
            } else {
                generator.notificationOccurred(.error)
            }
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
            title: NSLocalizedString("Mark All Read", comment: ""),
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
        feed.finishLoading(dismissRefresh: dismissRefresh, animated: animated)
        updateUnreadState()
    }

    private func handle(result: NotificationClient.Result, append: Bool, animated: Bool, page: Int) {
        // in case coming from "mark all" action
        self.resetRightBarItem()

        switch result {
        case .success(let notifications, let next):
            let block = {
                // disable the page model if there is no next
                self.page = next != nil ? NSNumber(integerLiteral: next!) : nil
                self.hasError = false

                self.update(dismissRefresh: !append, animated: animated)
            }

            let width = self.view.bounds.width

            if append {
                self.dataSource.append(width: width, notifications: notifications, completion: block)
            } else {
                self.dataSource.update(width: width, notifications: notifications, completion: block)
            }
        case .failed:
            StatusBar.showNetworkError()
            self.hasError = true
            self.update(dismissRefresh: !append, animated: animated)
        }
    }

    private func reload() {
        let first = 1
        client.requestNotifications(all: true, page: first) { result in
            self.handle(result: result, append: false, animated: true, page: first)
        }
    }

    private func nextPage() {
        let next = (page?.intValue ?? 0)
        client.requestNotifications(all: true, page: next) { result in
            self.handle(result: result, append: true, animated: false, page: next)
        }
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        guard hasError == false else { return [] }

        var objects: [ListDiffable] = [selection]

        let viewModels = selection.unreadSelected ? dataSource.unreadNotifications : dataSource.allNotifications

        if viewModels.count == 0 && feed.status == .idle {
            objects.append(emptyKey)
        } else {
            objects += viewModels as [ListDiffable]

            // only append paging if there are visible notifications
            if let page = self.page {
                objects.append(page)
            }
        }

        return objects
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let object = object as? ListDiffable else { fatalError("Object not diffable") }

        // 28 is the default height of UISegmentedControl
        let controlHeight = 28 + 2*Styles.Sizes.rowSpacing

        if object === page { return NotificationNextPageSectionController(delegate: self) }
        else if object === emptyKey { return NoNewNotificationSectionController(topInset: controlHeight, topLayoutGuide: topLayoutGuide) }

        switch object {
        case is SegmentedControlModel: return SegmentedControlSectionController(delegate: self, height: controlHeight)
        case is NotificationViewModel: return NotificationSectionController(client: client, dataSource: dataSource)
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
        return false
    }

    // MARK: NotificationClientListener

    func willMarkRead(client: NotificationClient, id: String) {
        dataSource.setOptimisticRead(id: id)
        update(dismissRefresh: false, animated: true)
    }

    func didFailToMarkRead(client: NotificationClient, id: String) {
        dataSource.removeOptimisticRead(id: id)
        StatusBar.showGenericError()
        update(dismissRefresh: false, animated: true)
    }

    // MARK: NotificationNextPageSectionControllerDelegate

    func didSelect(notificationSectionController: NotificationNextPageSectionController) {
        nextPage()
    }
    
    // MARK: FeedSelectionProviding
    
    var feedContainsSelection: Bool {
        return feed.collectionView.indexPathsForSelectedItems?.count != 0
    }

    // MARK: ForegroundHandlerDelegate

    func didForeground(handler: ForegroundHandler) {
        feed.refreshHead()
    }
    
}
