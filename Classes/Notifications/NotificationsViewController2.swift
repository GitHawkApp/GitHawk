//
//  NotificationsViewController2.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/8/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import FlatCache

final class NotificationsViewController2: BaseListViewController2<Int>,
BaseListViewController2DataSource,
ForegroundHandlerDelegate, FlatCacheListener {

    private let modelController: NotificationModelController
    private let foreground = ForegroundHandler(threshold: 5 * 60)
    private let inboxType: InboxType
    private var notificationIDs = [String]()

    private var notifications: [NotificationViewModel2] {
        return notificationIDs.compactMap { modelController.githubClient.cache.get(id: $0) }
    }

    init(modelController: NotificationModelController, inboxType: InboxType) {
        self.modelController = modelController
        self.inboxType = inboxType

        super.init(emptyErrorMessage: NSLocalizedString("Cannot load your inbox.", comment: ""))
        
        self.dataSource = self
        self.foreground.delegate = self

        switch inboxType {
        case .all: title = NSLocalizedString("All", comment: "")
        case .unread: title = NSLocalizedString("Inbox", comment: "")
        case .repo(let repo): title = repo.name
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
                action: #selector(NotificationsViewController2.onMore(sender:))
            )
            item.accessibilityLabel = NSLocalizedString("More options", comment: "")
            navigationItem.leftBarButtonItem = item
        case .repo, .all: break
        }

        navigationController?.tabBarItem.badgeColor = Styles.Colors.Red.medium.color
    }

    override func fetch(page: Int?) {
        let width = view.bounds.width
        let showAll = inboxType.showAll

        let repo: Repository?
        switch inboxType {
        case .repo(let r): repo = r
        case .all, .unread: repo = nil
        }

        if let page = page {
            modelController.fetchNotifications(repo: repo, all: showAll, page: page, width: width) { [weak self] result in
                self?.handle(result: result, append: true, animated: false, page: page)
            }
        } else {
            let first = 1
            modelController.fetchNotifications(repo: repo, all: showAll, page: first, width: width) { [weak self] result in
                self?.handle(result: result, append: false, animated: trueUnlessReduceMotionEnabled, page: first)
            }
        }
    }

    private func handle(result: Result<([NotificationViewModel2], Int?)>, append: Bool, animated: Bool, page: Int) {
        switch result {
        case .success(let notifications, let next):
            var ids = [String]()
            notifications.forEach {
                modelController.githubClient.cache.add(listener: self, value: $0)
                ids.append($0.id)
            }
            rebuildAndUpdate(ids: ids, append: append, page: next, animated: animated)
        case .error:
            error(animated: trueUnlessReduceMotionEnabled)
            ToastManager.showNetworkError()
        }

        // set after updating so self.models has already been changed
        updateUnreadState()
    }

    private func updateUnreadState() {
        // don't update tab bar and badges when not showing only new notifications
        // prevents archives updating badge and tab #s
        switch inboxType {
        case .all, .repo: return
        case .unread: break
        }

        var unread = 0
        for id in notificationIDs {
            guard let model = modelController.githubClient.cache.get(id: id) as NotificationViewModel2?,
                !model.read
                else { continue }
            unread += 1
        }

        let hasUnread = unread > 0
        navigationItem.rightBarButtonItem?.isEnabled = hasUnread
        navigationController?.tabBarItem.badgeValue = hasUnread ? "\(unread)" : nil
        BadgeNotifications.update(count: unread)
    }

    @objc func onMore(sender: UIBarButtonItem) {
        let alert = UIAlertController.configured(preferredStyle: .actionSheet)

        alert.add(action: UIAlertAction(
            title: NSLocalizedString("View All", comment: ""),
            style: .default,
            handler: { [weak self] _ in
                self?.onViewAll()
        }))

        let cache = modelController.githubClient.cache
        var repoNames = Set<String>()
        for id in notificationIDs {
            guard let model = cache.get(id: id) as NotificationViewModel2?,
                !repoNames.contains(model.repo)
                else { continue }
            repoNames.insert(model.repo)
            alert.add(action: UIAlertAction(title: model.repo, style: .default, handler: { [weak self] _ in
                self?.pushRepoNotifications(owner: model.owner, repo: model.repo)
            }))
        }

        alert.add(action: AlertAction.cancel())
        alert.popoverPresentationController?.barButtonItem = sender
        present(alert, animated: true)
    }

    func pushRepoNotifications(owner: String, repo: String) {
        let controller = NotificationsViewController2(
            modelController: modelController,
            inboxType: .repo(Repository(owner: owner, name: repo))
        )
        navigationController?.pushViewController(controller, animated: trueUnlessReduceMotionEnabled)
    }

    func onViewAll() {
        let controller = NotificationsViewController2(
            modelController: modelController,
            inboxType: .all
        )
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
            updateUnreadState()
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
        case .all, .unread: modelController.markAllNotifications(completion: block)
        case .repo(let repo): modelController.markRepoNotifications(repo: repo, completion: block)
        }
    }

    private func rebuildAndUpdate(
        ids: [String],
        append: Bool,
        page: Int?,
        animated: Bool
        ) {
        if append {
            notificationIDs += ids
        } else {
            notificationIDs = ids
        }
        update(page: page, animated: animated)
    }

    // MARK: BaseListViewController2DataSource

    func models(adapter: ListSwiftAdapter) -> [ListSwiftPair] {
        return notificationIDs.compactMap { id in
            guard let model = modelController.githubClient.cache.get(id: id) as NotificationViewModel2?
                else { return nil }
            return ListSwiftPair.pair(model) { [modelController] in
                NotificationSectionController2(modelController: modelController)
            }
        }
    }

    // MARK: ForegroundHandlerDelegate

    func didForeground(handler: ForegroundHandler) {
        feed.refreshHead()
    }

    // MARK: FlatCacheListener

    func flatCacheDidUpdate(cache: FlatCache, update: FlatCache.Update) {
        self.update(animated: trueUnlessReduceMotionEnabled)
        updateUnreadState()
    }
    
}
