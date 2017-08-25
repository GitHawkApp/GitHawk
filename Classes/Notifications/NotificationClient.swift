//
//  NotificationClient.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/30/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

protocol NotificationClientListener: class {
    func willMarkRead(client: NotificationClient, id: String, isOpen: Bool)
    func didFailToMarkRead(client: NotificationClient, id: String, isOpen: Bool)
}

final class NotificationClient {

    private class ListenerWrapper: NSObject {
        weak var listener: NotificationClientListener? = nil
    }
    private var listeners = [ListenerWrapper]()

    enum Result {
        case failed(Error?)
        case success([Notification], Int?)
    }

    let githubClient: GithubClient

    init(githubClient: GithubClient) {
        self.githubClient = githubClient
    }

    // Public API

    static private let openOnReadKey = "com.freetime.NotificationClient.read-on-open"

    static func readOnOpen() -> Bool {
        return UserDefaults.standard.bool(forKey: openOnReadKey)
    }

    static func setReadOnOpen(open: Bool) {
        UserDefaults.standard.set(open, forKey: openOnReadKey)
    }

    func add(listener: NotificationClientListener) {
        let wrapper = ListenerWrapper()
        wrapper.listener = listener
        listeners.append(wrapper)
    }

    // https://developer.github.com/v3/activity/notifications/#list-your-notifications
    func requestNotifications(
        all: Bool = false,
        participating: Bool = false,
        since: Date? = nil,
        page: Int = 1,
        before: Date? = nil,
        completion: @escaping (Result) -> ()
        ) {
        var parameters: [String: Any] = [
            "all": all ? "true" : "false",
            "participating": participating ? "true" : "false",
            "page": page,
            "per_page": "100",
            ]
        if let since = since {
            parameters["since"] = GithubAPIDateFormatter().string(from: since)
        }
        if let before = before {
            parameters["before"] = GithubAPIDateFormatter().string(from: before)
        }

        typealias NotificationsPayload = [[String: Any]]

        let success = { (jsonArr: NotificationsPayload, page: Int?) in
            var notifications = [Notification]()
            for json in jsonArr {
                if let notification = Notification(json: json) {
                    notifications.append(notification)
                }
            }

            completion(.success(notifications, page))
        }

        githubClient.request(GithubClient.Request(
            path: "notifications",
            method: .get,
            parameters: parameters,
            headers: nil
        ) { (response, nextPage) in
            if let jsonArr = response.value as? NotificationsPayload {
                success(jsonArr, nextPage?.next)
            } else {
                completion(.failed(response.error))
            }
        })
    }

    typealias MarkAllCompletion = (Bool) -> ()
    func markAllNotifications(completion: MarkAllCompletion? = nil) {
        githubClient.request(GithubClient.Request(
            path: "notifications",
            method: .put) { (response, _) in
                guard let completion = completion else { return }
                // https://developer.github.com/v3/activity/notifications/#mark-as-read
                let success = response.response?.statusCode == 205
                completion(success)
        })
    }

    func markNotificationRead(id: String, isOpen: Bool) {
        for wrapper in listeners {
            if let listener = wrapper.listener {
                listener.willMarkRead(client: self, id: id, isOpen: isOpen)
            }
        }

        githubClient.request(GithubClient.Request(
            path: "notifications/threads/\(id)",
            method: .patch) { (response, _) in
                // https://developer.github.com/v3/activity/notifications/#mark-a-thread-as-read
                let success = response.response?.statusCode == 205
                if !success {
                    for wrapper in self.listeners {
                        if let listener = wrapper.listener {
                            listener.didFailToMarkRead(client: self, id: id, isOpen: isOpen)
                        }
                    }
                }
        })
    }

}
