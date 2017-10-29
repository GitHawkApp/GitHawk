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
import FlatCache

class NotificationsViewController: BaseListViewController<NSNumber>,
//    NotificationClientListener,
ForegroundHandlerDelegate,
RatingSectionControllerDelegate,
PrimaryViewController,
TabNavRootViewControllerType,
BaseListViewControllerDataSource,
FlatCacheListener {

    private let client: NotificationClient
    private let foreground = ForegroundHandler(threshold: 5 * 60)
    private let showRead: Bool

    // todo
    private var notificationIDs = [String]()

    // set to nil and update to dismiss the rating control
    private var ratingToken: RatingToken? = RatingController.inFeedToken()

    init(client: NotificationClient, showRead: Bool) {
        self.client = client
        self.showRead = showRead

        super.init(
            emptyErrorMessage: NSLocalizedString("Cannot load your inbox.", comment: ""),
            dataSource: self
        )

        self.foreground.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        resetLeftBarItem()
        if !showRead {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: NSLocalizedString("Archives", comment: ""),
                style: .plain,
                target: self,
                action: #selector(NotificationsViewController.onViewAll)
            )
        }

        navigationController?.tabBarItem.badgeColor = Styles.Colors.Red.medium.color

        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = showRead ? .never : .always
        }
    }

    // MARK: Private API

    @objc
    func onViewAll() {
        let controller = NotificationsViewController(client: client, showRead: true)
        controller.title = NSLocalizedString("Archives", comment: "")
        navigationController?.pushViewController(controller, animated: true)
    }

    func resetLeftBarItem() {
        if !showRead {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                title: NSLocalizedString("Mark All", comment: ""),
                style: .plain,
                target: self,
                action: #selector(NotificationsViewController.onMarkAll(sender:))
            )
        }
    }

    private func updateUnreadState(count: Int) {
        // don't update tab bar and badges when not showing only new notifications
        // prevents archives updating badge and tab #s
        guard !showRead else { return }

        let hasUnread = count > 0
        navigationItem.leftBarButtonItem?.isEnabled = hasUnread
        navigationController?.tabBarItem.badgeValue = hasUnread ? "\(count)" : nil
        BadgeNotifications.update(count: count)
    }

    private func markAllRead() {
        self.setLeftBarItemSpinning()
        self.client.markAllNotifications { success in
            let generator = UINotificationFeedbackGenerator()
            if success {
                generator.notificationOccurred(.success)

                // clear all badges
                BadgeNotifications.update(count: 0)
            } else {
                generator.notificationOccurred(.error)
            }
            self.fetch(page: nil)

            // "mark all" is an engaging action, system prompt on it
            RatingController.prompt(.system)
        }
    }

    @objc private func onMarkAll(sender: UIBarButtonItem) {
        let alert = UIAlertController.configured(
            title: NSLocalizedString("Notifications", comment: ""),
            message: NSLocalizedString("Mark all notifications as read?", comment: ""),
            preferredStyle: .alert
        )

        alert.addActions([
            AlertAction.markAll({ [weak self] _ in
                self?.markAllRead()
            }),
            AlertAction.cancel()
        ])

        present(alert, animated: true)
    }

    private func handle(result: Result<([NotificationViewModel], Int?)>, append: Bool, animated: Bool, page: Int) {
        switch result {
        case .success(let notifications, let next):
            var ids = [String]()
            notifications.forEach {
                client.githubClient.cache.add(listener: self, value: $0)
                ids.append($0.id)
            }
            rebuildAndUpdate(ids: ids, page: next as NSNumber?, animated: animated)
        case .error:
            error(animated: true)
            ToastManager.showNetworkError()
        }

        // set after updating so self.models has already been changed
        self.resetLeftBarItem()
    }

    private func rebuildAndUpdate(
        ids: [String],
        page: NSNumber?,
        animated: Bool
        ) {
        if page == nil {
            notificationIDs = ids
        } else {
            notificationIDs += ids
        }
        update(page: page, animated: animated)
    }

    // MARK: Overrides

    override func fetch(page: NSNumber?) {
        let width = view.bounds.width
        if let page = page?.intValue {
            client.requestNotifications(all: showRead, page: page, width: width) { [weak self] result in
                self?.handle(result: result, append: true, animated: false, page: page)
            }
        } else {
            let first = 1
            client.requestNotifications(all: showRead, page: first, width: width) { [weak self] result in
                self?.handle(result: result, append: false, animated: true, page: first)
            }
        }
    }

    // MARK: BaseListViewControllerDataSource

    func headModels(listAdapter: ListAdapter) -> [ListDiffable] {
        return []
    }

    func models(listAdapter: ListAdapter) -> [ListDiffable] {
        var models = [NotificationViewModel]()

        for id in notificationIDs {
            if let model = client.githubClient.cache.get(id: id) as NotificationViewModel?,
                (showRead || !model.read) {
                // swap the model if not read, otherwise exclude it
                // this powers the "swipe to archive" feature deleting the cell
                models.append(model)
            }
        }

        // every time the list is updated, update bar items and badges
        updateUnreadState(count: models.count)

        return models
    }

    func sectionController(model: Any, listAdapter: ListAdapter) -> ListSectionController {
        switch model {
        case is NotificationViewModel: return NotificationSectionController(client: client)
        case is RatingToken: return RatingSectionController(delegate: self)
        default: fatalError("Unhandled object: \(model)")
        }
    }

    func emptySectionController(listAdapter: ListAdapter) -> ListSectionController {
        return NoNewNotificationSectionController(
            topInset: 0,
            topLayoutGuide: topLayoutGuide,
            bottomLayoutGuide: bottomLayoutGuide
        )
    }

    // MARK: ForegroundHandlerDelegate

    func didForeground(handler: ForegroundHandler) {
        feed.refreshHead()
    }

    // MARK: RatingSectionControllerDelegate

    func ratingNeedsDismiss(sectionController: RatingSectionController) {
        ratingToken = nil
        update(animated: true)
    }

    // MARK: TabNavRootViewControllerType

    func didSingleTapTab() {
        feed.collectionView.scrollToTop(animated: true)
    }

    func didDoubleTapTab() {}

    // MARK: FlatCacheListener

    func flatCacheDidUpdate(cache: FlatCache, update: FlatCache.Update) {
        self.update(animated: true)
    }

}
