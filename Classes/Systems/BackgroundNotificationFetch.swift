//
//  BackgroundNotificationFetch.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class BackgroundNotificationFetch {

    private static let key = "com.freetime.backgroundnotificationfetch.enabled"
    static var isEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: BackgroundNotificationFetch.key)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: BackgroundNotificationFetch.key)
        }
    }

    static func configure(application: UIApplication) {
        application.setMinimumBackgroundFetchInterval(isEnabled ? 30 * 60: UIApplicationBackgroundFetchIntervalNever)
    }

    static func fetch(application: UIApplication, handler: (UIBackgroundFetchResult) -> Void) {
        let manager = GithubSessionManager()
        guard let session = manager.userSession else { return }
        let client = newGithubClient(sessionManager: manager, userSession: session)
        client.request(GithubClient.Request(
            path: "notifications",
            method: .get,
            parameters: ["all": "false"],
            completion: { (response, _) in
                if let notes = response.value as? [ [String: Any] ] {
                    application.applicationIconBadgeNumber = notes.count
                }
        }))
    }

}
