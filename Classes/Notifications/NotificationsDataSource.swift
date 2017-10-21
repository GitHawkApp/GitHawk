//
//  NotificationsDataSource.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class NotificationsDataSource {

    private let archivePath: String = {
        return FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            // crash intentionally on startup if doesn't exist
            .first!
            .appendingPathComponent("cached_notifications")
            .path
    }()
    private var _notifications = [NotificationViewModel]()
    private var _optimisticReadIDs = Set<String>()

    // MARK: Public API

    func warm(width: CGFloat) {
        if let archive = NSKeyedUnarchiver.unarchiveObject(withFile: archivePath) as? [Notification] {
            _notifications = CreateViewModels(containerWidth: width, notifications: archive)
        }
    }

    func update(notifications: [NotificationViewModel]) {
        _notifications = notifications
    }

    func append(notifications: [NotificationViewModel]) {
        _notifications += notifications
    }

    var allNotifications: [NotificationViewModel] {
        return _notifications
    }

    var unreadNotifications: [NotificationViewModel] {
        return _notifications.filter({ (model) -> Bool in
            return !model.read && !self._optimisticReadIDs.contains(model.id)
        })
    }

    var hasReadItems: Bool {
        return unreadNotifications.count > 0
    }

    func isRead(notification: NotificationViewModel) -> Bool {
        return notification.read || _optimisticReadIDs.contains(notification.id)
    }

    func setOptimisticRead(id: String) {
        _optimisticReadIDs.insert(id)
    }

    func removeOptimisticRead(id: String) {
        _optimisticReadIDs.remove(id)
    }

}
