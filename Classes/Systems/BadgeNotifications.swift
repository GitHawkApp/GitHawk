//
//  BadgeNotifications.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class BadgeNotifications {

    private static let key = "com.freetime.BadgeNotifications.enabled"
    static var isEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: BadgeNotifications.key)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: BadgeNotifications.key)
        }
    }

    static func configure(application: UIApplication) {
        let interval = isEnabled ? 60 * 60 : UIApplicationBackgroundFetchIntervalNever
        application.setMinimumBackgroundFetchInterval(interval)
    }

    static func fetch(application: UIApplication, handler: @escaping (UIBackgroundFetchResult) -> Void) {
        let manager = GithubSessionManager()
        guard let session = manager.userSession,
            isEnabled
            else { return }

        let client = newGithubClient(sessionManager: manager, userSession: session)
        client.request(GithubClient.Request(
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
    static func update(application: UIApplication, count: Int) -> Bool {
        let changed = application.applicationIconBadgeNumber != count
        application.applicationIconBadgeNumber = count
        return changed
    }

    static func decrease(application: UIApplication) {
        update(application: application, count: application.applicationIconBadgeNumber - 1)
    }

    static func increase(application: UIApplication) {
        update(application: application, count: application.applicationIconBadgeNumber + 1)
    }

}
