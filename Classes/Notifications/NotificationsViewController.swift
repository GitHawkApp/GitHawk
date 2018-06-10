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

enum InboxType {
    case unread
    case repo(Repository)
    case all

    var showAll: Bool {
        switch self {
        case .all, .repo: return true
        case .unread: return false
        }
    }
}

class NotificationsViewController: BaseListViewController<NSNumber>,
ForegroundHandlerDelegate,
RatingSectionControllerDelegate,
PrimaryViewController,
TabNavRootViewControllerType,
BaseListViewControllerDataSource,
FlatCacheListener {

    private let client: NotificationClient
    private let foreground = ForegroundHandler(threshold: 5 * 60)
    private let inboxType: InboxType
    private var notificationIDs = [String]()

    // set to nil and update to dismiss the rating control
    private var ratingToken: RatingToken? = RatingController.inFeedToken()

    init(client: NotificationClient, inboxType: InboxType) {
        self.client = client
        self.inboxType = inboxType

        super.init(
            emptyErrorMessage: NSLocalizedString("Cannot load your inbox.", comment: "")
        )
        self.dataSource = self
        self.foreground.delegate = self

        switch inboxType {
        case .all:
            title = NSLocalizedString("All", comment: "")
        case .unread:
            title = NSLocalizedString("Inbox", comment: "")
        case .repo(let repo):
            title = repo.name
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        makeBackBarItemEmpty()
        resetRightBarItem()

        switch inboxType {
        case .unread:
            let item = UIBarButtonItem(
                image: UIImage(named: "bullets-hollow"),
                style: .plain,
                target: self,
                action: #selector(NotificationsViewController.onMore(sender:))
            )
            item.accessibilityLabel = NSLocalizedString("More options", comment: "")
            navigationItem.leftBarButtonItem = item
        case .repo, .all: break
        }

        navigationController?.tabBarItem.badgeColor = Styles.Colors.Red.medium.color
    }

    // MARK: Private API

    @objc func onMore(sender: UIBarButtonItem) {
        let alert = UIAlertController.configured(preferredStyle: .actionSheet)

        alert.add(action: UIAlertAction(
            title: NSLocalizedString("View All", comment: ""),
            style: .default,
            handler: { [weak self] _ in
                self?.onViewAll()
        }))

        let cache = client.githubClient.cache
        var repoNames = Set<String>()
        for id in notificationIDs {
            guard let notification = cache.get(id: id) as NotificationViewModel?,
                !repoNames.contains(notification.repo)
                else { continue }
            repoNames.insert(notification.repo)
            alert.add(action: UIAlertAction(title: notification.repo, style: .default, handler: { [weak self] _ in
                self?.pushRepoNotifications(owner: notification.owner, repo: notification.repo)
            }))
        }

        alert.add(action: AlertAction.cancel())

        alert.popoverPresentationController?.barButtonItem = sender

        present(alert, animated: true)
    }

    func pushRepoNotifications(owner: String, repo: String) {
        let model = Repository(owner: owner, name: repo)
        let controller = NotificationsViewController(client: client, inboxType: .repo(model))
        navigationController?.pushViewController(controller, animated: trueUnlessReduceMotionEnabled)
    }

    func onViewAll() {
        let controller = NotificationsViewController(client: client, inboxType: .all)
        navigationController?.pushViewController(controller, animated: trueUnlessReduceMotionEnabled)
    }

    func resetRightBarItem(updatingState updateState: Bool = true) {
        let item = UIBarButtonItem(
            image: UIImage(named: "check"),
            style: .plain,
            target: self,
            action: #selector(onMarkAll)
        )
        item.accessibilityLabel = NSLocalizedString("Mark notifications read", comment: "")
        navigationItem.rightBarButtonItem = item
        if updateState {
            updateUnreadState(count: notificationIDs.count)
        }
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

                // change the spinner to the mark all item
                // don't update state here; it is managed by `fetch`
                self.resetRightBarItem(updatingState: false)
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
        updateUnreadState(count: notificationIDs.count)
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

    // MARK: Overrides

    override func fetch(page: NSNumber?) {
        let width = view.bounds.width
        let showAll = inboxType.showAll

        let repo: Repository?
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

        let showAll = inboxType.showAll
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
            layoutInsets: view.safeAreaInsets
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
        self.update(animated: trueUnlessReduceMotionEnabled)
    }

}
