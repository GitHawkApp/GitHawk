//
//  BadgeNotifications.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import UserNotifications

final class BadgeNotifications {

    private static let userKey = "com.freetime.BadgeNotifications.user-enabled"
    private static let countWhenDisabledKey = "com.freetime.BadgeNotifications.count-when-disabled"

    static var isEnabled: Bool {
        get {
            let defaults = UserDefaults.standard
            return defaults.bool(forKey: userKey)
        }
        set {
            let defaults = UserDefaults.standard
            let application = UIApplication.shared
            if newValue == false {
                defaults.set(application.applicationIconBadgeNumber, forKey: countWhenDisabledKey)
                application.applicationIconBadgeNumber = 0
            } else {
                application.applicationIconBadgeNumber = defaults.integer(forKey: countWhenDisabledKey)
            }
            defaults.set(newValue, forKey: BadgeNotifications.userKey)
        }
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
                    callback(isEnabled ? .enabled : .disabled)
                }
            }
        }
    }

    static func configure(application: UIApplication = UIApplication.shared, permissionHandler: ((Bool) -> Void)? = nil) {
        if isEnabled {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge], completionHandler: { (granted, _) in
                permissionHandler?(granted)
            })
            application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        } else {
            application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalNever)
        }
    }

    static func fetch(application: UIApplication = UIApplication.shared, handler: @escaping (UIBackgroundFetchResult) -> Void) {
        let manager = GithubSessionManager()
        guard let session = manager.focusedUserSession,
            isEnabled
            else { return }

        let client = newGithubClient(sessionManager: manager, userSession: session)
        client.request(GithubClient.Request(
            client: session.client,
            path: "notifications",
            method: .get,
            parameters: ["all": "false"],
            completion: { (response, _) in
                if let notes = response.value as? [ [String: Any] ] {
                    handler(update(application: application, count: notes.count) ? .newData : .noData)
                } else {
                    handler(.failed)
                }
        }))
    }

    @discardableResult
    static func update(application: UIApplication = UIApplication.shared, count: Int) -> Bool {
        let enabledCount = isEnabled ? count : 0
        let changed = application.applicationIconBadgeNumber != enabledCount
        application.applicationIconBadgeNumber = enabledCount
        return changed
    }

}
