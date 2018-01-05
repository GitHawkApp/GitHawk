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

    enum InboxType {
        case unread
        case repo(NotificationClient.NotificationRepository)
        case all
    }

    private let client: NotificationClient
    private let foreground = ForegroundHandler(threshold: 5 * 60)
    private let inboxType: InboxType
    private var notificationIDs = [String]()
    private var subscriptionController: NotificationSubscriptionsController?

    // set to nil and update to dismiss the rating control
    private var ratingToken: RatingToken? = RatingController.inFeedToken()

    init(client: NotificationClient, inboxType: InboxType) {
        self.client = client
        self.inboxType = inboxType

        super.init(
            emptyErrorMessage: NSLocalizedString("Cannot load your inbox.", comment: ""),
            dataSource: self
        )

        self.foreground.delegate = self

        switch inboxType {
        case .all:
            title = NSLocalizedString("Archived", comment: "")
        case .unread:
            title = NSLocalizedString("Inbox", comment: "")
            self.subscriptionController = NotificationSubscriptionsController(viewController: self, client: client)
        case .repo(let repo):
            title = repo.name
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        resetRightBarItem()

        switch inboxType {
        case .unread:
            let item = UIBarButtonItem(
                image: UIImage(named: "bullets-hollow"),
                style: .plain,
                target: self,
                action: #selector(NotificationsViewController.onMore)
            )
            item.accessibilityLabel = NSLocalizedString("More options", comment: "")
            navigationItem.leftBarButtonItem = item
        case .repo, .all: break
        }

        navigationController?.tabBarItem.badgeColor = Styles.Colors.Red.medium.color
    }

    // MARK: Private API

    @objc func onMore() {
        let alert = UIAlertController.configured(preferredStyle: .actionSheet)

        alert.add(action: UIAlertAction(
            title: NSLocalizedString("View Archived", comment: ""),
            style: .default,
            handler: { [weak self] _ in
                self?.onViewAll()
        }))
        subscriptionController?.actions.forEach { alert.add(action: $0) }
        alert.add(action: AlertAction.cancel())

        present(alert, animated: true)
    }

    func onViewAll() {
        let controller = NotificationsViewController(client: client, inboxType: .all)
        navigationController?.pushViewController(controller, animated: trueUnlessReduceMotionEnabled)
    }

    func resetRightBarItem() {
        let item = UIBarButtonItem(
            image: UIImage(named: "check"),
            style: .plain,
            target: self,
            action: #selector(onMarkAll)
        )
        item.accessibilityLabel = NSLocalizedString("Mark notifications read", comment: "")
        navigationItem.rightBarButtonItem = item
        updateUnreadState(count: notificationIDs.count)
    }

    private func updateUnreadState(count: Int) {
        // don't update tab bar and badges when not showing only new notifications
        // prevents archives updating badge and tab #s
        switch inboxType {
            case .all, .repo: return
            case .unread: break
        }

        let hasUnread = count > 0
        navigationItem.rightBarButtonItem?.isEnabled = hasUnread
        navigationController?.tabBarItem.badgeValue = hasUnread ? "\(count)" : nil
        BadgeNotifications.update(count: count)
    }

    private func markRead() {
        self.setRightBarItemSpinning()

        let block: (Bool) -> Void = { success in
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

        switch inboxType {
        case .all, .unread: client.markAllNotifications(completion: block)
        case .repo(let repo): client.markRepoNotifications(repo: repo, completion: block)
        }
    }

    @objc private func onMarkAll() {
        let message: String
        switch inboxType {
        case .all, .unread:
            message = NSLocalizedString("Mark all notifications as read?", comment: "")
        case .repo(let repo):
            let messageFormat = NSLocalizedString("Mark %@ notifications as read?", comment: "")
            message = String(format: messageFormat, repo.name)
        }

        let alert = UIAlertController.configured(
            title: NSLocalizedString("Notifications", comment: ""),
            message: message,
            preferredStyle: .alert
        )

        alert.addActions([
            UIAlertAction(
                title: NSLocalizedString("Mark Read", comment: ""),
                style: .destructive,
                handler: { [weak self] _ in
                    self?.markRead()
            }),
            AlertAction.cancel()
        ])

        present(alert, animated: trueUnlessReduceMotionEnabled)
    }

    private func handle(result: Result<([NotificationViewModel], Int?)>, append: Bool, animated: Bool, page: Int) {
        switch result {
        case .success(let notifications, let next):
            var ids = [String]()
            notifications.forEach {
                client.githubClient.cache.add(listener: self, value: $0)
                ids.append($0.id)
            }
            rebuildAndUpdate(ids: ids, append: append, page: next as NSNumber?, animated: animated)
        case .error:
            error(animated: trueUnlessReduceMotionEnabled)
            ToastManager.showNetworkError()
        }

        // set after updating so self.models has already been changed
        self.resetRightBarItem()
    }

    private func rebuildAndUpdate(
        ids: [String],
        append: Bool,
        page: NSNumber?,
        animated: Bool
        ) {
        if append {
            notificationIDs += ids
        } else {
            notificationIDs = ids
        }
        update(page: page, animated: animated)
    }

    private var showAll: Bool {
        switch inboxType {
        case .all, .repo: return true
        case .unread: return false
        }
    }

    // MARK: Overrides

    override func fetch(page: NSNumber?) {
        subscriptionController?.fetchSubscriptions()

        let width = view.bounds.width

        let repo: NotificationClient.NotificationRepository?
        switch inboxType {
        case .repo(let r): repo = r
        case .all, .unread: repo = nil
        }

        if let page = page?.intValue {
            client.fetchNotifications(repo: repo, all: showAll, page: page, width: width) { [weak self] result in
                self?.handle(result: result, append: true, animated: false, page: page)
            }
        } else {
            let first = 1
            client.fetchNotifications(repo: repo, all: showAll, page: first, width: width) { [weak self] result in
                self?.handle(result: result, append: false, animated: trueUnlessReduceMotionEnabled, page: first)
            }
        }
    }

    // MARK: BaseListViewControllerDataSource

    func headModels(listAdapter: ListAdapter) -> [ListDiffable] {
        return []
    }

    func models(listAdapter: ListAdapter) -> [ListDiffable] {
        var models = [NotificationViewModel]()

        let showAll = self.showAll
        for id in notificationIDs {
            if let model = client.githubClient.cache.get(id: id) as NotificationViewModel?,
                (showAll || !model.read) {
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
        update(animated: trueUnlessReduceMotionEnabled)
    }

    // MARK: TabNavRootViewControllerType

    func didSingleTapTab() {
        feed.collectionView.scrollToTop(animated: trueUnlessReduceMotionEnabled)
    }

    func didDoubleTapTab() {}

    // MARK: FlatCacheListener

    func flatCacheDidUpdate(cache: FlatCache, update: FlatCache.Update) {
        switch update {
        case .item: self.update(animated: trueUnlessReduceMotionEnabled)
        case .list: break
        }
    }

}
