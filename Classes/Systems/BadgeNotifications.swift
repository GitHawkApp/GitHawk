//
//  BadgeNotifications.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import UserNotifications
import GitHubAPI
import GitHubSession

final class BadgeNotifications {

    private static let countWhenDisabledKey = "com.freetime.BadgeNotifications.count-when-disabled"
    private static let defaults = UserDefaults.standard

    private static let userKey = "com.freetime.BadgeNotifications.user-enabled"
    static var isBadgeEnabled: Bool {
        get {
            return defaults.bool(forKey: userKey)
        }
        set {
            let application = UIApplication.shared
            if newValue == false {
                defaults.set(application.applicationIconBadgeNumber, forKey: countWhenDisabledKey)
                application.applicationIconBadgeNumber = 0
            } else {
                application.applicationIconBadgeNumber = defaults.integer(forKey: countWhenDisabledKey)
            }
            defaults.set(newValue, forKey: userKey)
        }
    }

    private static let notificationKey = "com.freetime.BadgeNotifications.notifications-enabled"
    static var isLocalNotificationEnabled: Bool {
        get { return defaults.bool(forKey: notificationKey) }
        set { return defaults.set(newValue, forKey: notificationKey)}
    }

    enum State {
        case initial
        case denied
        case disabled
        case enabled
    }

    static func check(callback: @escaping (State) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .notDetermined:
                    callback(.initial)
                case .denied:
                    callback(.denied)
                case .authorized:
                    callback(isBadgeEnabled || isLocalNotificationEnabled ? .enabled : .disabled)
                }
            }
        }
    }

    static func configure(
        application: UIApplication = UIApplication.shared,
        permissionHandler: ((Bool) -> Void)? = nil
        ) {
        var options = UNAuthorizationOptions()
        if isBadgeEnabled {
            options.insert(.badge)
        }
        if isLocalNotificationEnabled {
            options.insert(.alert)
        }

        if !options.isEmpty {
            UNUserNotificationCenter.current().requestAuthorization(options: options, completionHandler: { (granted, _) in
                permissionHandler?(granted)
            })
            application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        } else {
            application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalNever)
        }
    }

    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func fetch(application: UIApplication, handler: @escaping (UIBackgroundFetchResult) -> Void) {
        let isBadgeEnabled = BadgeNotifications.isBadgeEnabled
        let isLocalNotificationEnabled = BadgeNotifications.isLocalNotificationEnabled
        guard isBadgeEnabled || isLocalNotificationEnabled else {
            handler(.noData)
            return
        }

        client.send(V3NotificationRequest(all: false)) { [weak self] result in
            switch result {
            case .success(let response):
                BadgeNotifications.updateBadge(
                    application: application,
                    count: response.data.count
                )
                self?.updateLocalNotificationCache(
                    notifications: response.data,
                    showAlert: isLocalNotificationEnabled,
                    completion: { changed in
                        handler(changed ? .newData : .noData)
                })
            case .failure:
                handler(.failed)
            }
        }
    }

    private lazy var localNotificationsCache = LocalNotificationsCache()

    func updateLocalNotificationCache(
        notifications: [V3Notification],
        showAlert: Bool,
        completion: ((Bool) -> Void)? = nil
        ) {
        localNotificationsCache.update(notifications: notifications) { [weak self] filtered in
            let changed = notifications.count != filtered.count
            if showAlert && changed {
                self?.sendLocalPush(for: filtered)
            }
            completion?(changed)
        }
    }

    private func sendLocalPush(for notifications: [V3Notification]) {
        print("sending local push for \(notifications.count)")
    }

    static func updateBadge(application: UIApplication = UIApplication.shared, count: Int) {
        application.applicationIconBadgeNumber = isBadgeEnabled ? count : 0
    }

}
