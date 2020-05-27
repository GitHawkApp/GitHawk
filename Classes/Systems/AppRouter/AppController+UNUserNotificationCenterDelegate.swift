//
//  AppController+UNUserNotificationCenterDelegate.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/9/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UserNotifications
import GitHubAPI

extension AppController: UNUserNotificationCenterDelegate {

    func attachNotificationDelegate() {
        UNUserNotificationCenter.current().delegate = self
    }

    // MARK: UNUserNotificationCenterDelegate

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
        ) {
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
        ) {
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier: break
        case UNNotificationDefaultActionIdentifier:
            if let (path, params) = response.notification.request.content.routableUserInfo {
                markNotificationRead(id: response.notification.request.identifier)
                router.handle(path: path, params: params)
            }
        default: print(response.actionIdentifier)
        }
        completionHandler()
    }

    func markNotificationRead(id: String) {
        if let githubClient = getAppClient() {
            let cache = githubClient.cache
            guard var model = cache.get(id: id) as NotificationViewModel?,
                !model.read
                else { return }

            model.read = true
            cache.set(value: model)

            githubClient.client.send(V3MarkThreadsRequest(id: id)) { result in
                switch result {
                case .success: break
                case .failure:
                    model.read = false
                    cache.set(value: model)
                }
            }
        }
    }
}
