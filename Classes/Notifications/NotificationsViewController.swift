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
        updateUnreadState()
    }

    private func updateUnreadState() {
        let unreadCount = models.reduce(0) { (total, model) -> Int in
            if let model = model as? NotificationViewModel {
                return total + (model.read ? 0 : 1)
            } else {
                return total
            }
        }
        let hasUnread = unreadCount > 0
        navigationItem.leftBarButtonItem?.isEnabled = hasUnread
        navigationController?.tabBarItem.badgeValue = hasUnread ? "\(unreadCount)" : nil
        BadgeNotifications.update(count: unreadCount)
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

    private func update(dismissRefresh: Bool, animated: Bool = true) {
        feed.finishLoading(dismissRefresh: dismissRefresh, animated: animated)
        updateUnreadState()
    }

    private func handle(result: Result<([NotificationViewModel], Int?)>, append: Bool, animated: Bool, page: Int) {
        switch result {
        case .success(let notifications, let next):
            notifications.forEach { client.githubClient.cache.add(listener: self, value: $0) }
            update(models: notifications, page: next as NSNumber?, append: append, animated: animated)
        case .error:
            error(animated: true)
            ToastManager.showNetworkError()
        }

        // set after updating so self.models has already been changed
        self.resetLeftBarItem()
    }

    // MARK: Overrides

    override func fetch(page: NSNumber?) {
        let width = view.bounds.width
        if let page = page?.intValue {
            client.requestNotifications(all: showRead, page: page, width: width) { result in
                self.handle(result: result, append: true, animated: false, page: page)
            }
        } else {
            let first = 1
            client.requestNotifications(all: showRead, page: first, width: width) { result in
                self.handle(result: result, append: false, animated: true, page: first)
            }
        }
    }

    // MARK: BaseListViewControllerDataSource

    func headModels(listAdapter: ListAdapter) -> [ListDiffable] {
        return []
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
        feed.adapter.performUpdates(animated: true)
    }

    // MARK: TabNavRootViewControllerType

    func didSingleTapTab() {
        feed.collectionView.scrollToTop(animated: true)
    }

    func didDoubleTapTab() {}

    // MARK: FlatCacheListener

    func flatCacheDidUpdate(cache: FlatCache, update: FlatCache.Update) {
        switch update {
        case .item(let item):
            // only handle NotificationViewModels
            if let notification = item as? NotificationViewModel {
                var models = [ListDiffable]()
                // do a pass over each model and search for the updated item
                for model in self.models {
                    // if not showing read items and the models match (id only)
                    if let currentNotification = model as? NotificationViewModel,
                        currentNotification.id == notification.id {
                        // swap the model if not read, otherwise exclude it
                        // this powers the "swipe to archive" feature deleting the cell
                        if showRead || !notification.read {
                            models.append(notification)
                        }
                    } else {
                        models.append(model)
                    }
                }
                self.update(models: models, animated: true)
                self.resetLeftBarItem()
            }
        case .list: break
        }
    }
    
}
