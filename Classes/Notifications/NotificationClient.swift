//
//  NotificationClient.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/30/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

protocol NotificationClientListener: class {
    func willMarkRead(client: NotificationClient, id: String)
    func didFailToMarkRead(client: NotificationClient, id: String)
}

final class NotificationClient {

    private class ListenerWrapper: NSObject {
        weak var listener: NotificationClientListener? = nil
    }
    private var listeners = [ListenerWrapper]()

    enum Result {
        case failed(Error?)
        case success([Notification])
    }

    let githubClient: GithubClient

    private var currentPage: Int = 0

    init(githubClient: GithubClient) {
        self.githubClient = githubClient
    }

    // Public API

    private var _localReadIDs = Set<String>()
    var localReadIDs: Set<String> {
        return _localReadIDs
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
        nextPage: Bool = false,
        before: Date? = nil,
        completion: @escaping (Result) -> ()
        ) {
        let page = nextPage ? currentPage + 1 : currentPage

        var parameters: [String: Any] = [
            "all": all ? "true" : "false",
            "participating": participating ? "true" : "false",
            "page": page,
            ]
        if let since = since {
            parameters["since"] = GithubAPIDateFormatter().string(from: since)
        }
        if let before = before {
            parameters["before"] = GithubAPIDateFormatter().string(from: before)
        }

        typealias NotificationsPayload = [[String: Any]]

        let success = { (jsonArr: NotificationsPayload) in
            // update the current page only when request is succesful
            self.currentPage = page

            var notifications = [Notification]()
            for json in jsonArr {
                if let notification = Notification(json: json) {
                    notifications.append(notification)
                }
            }

            completion(.success(notifications))
        }

        if let sampleJSON = loadSample(path: "notifications") as? NotificationsPayload {
            success(sampleJSON)
        } else {
            githubClient.request(GithubClient.Request(
                path: "notifications",
                method: .get,
                parameters: parameters,
                headers: nil
            ) { response in
                if let jsonArr = response.value as? NotificationsPayload {
                    success(jsonArr)
                } else {
                    completion(.failed(response.error))
                }
            })
        }
    }

    typealias MarkAllCompletion = (Bool) -> ()
    func markAllNotifications(completion: MarkAllCompletion? = nil) {
        githubClient.request(GithubClient.Request(
            path: "notifications",
            method: .put) { response in
                guard let completion = completion else { return }
                // https://developer.github.com/v3/activity/notifications/#mark-as-read
                let success = response.response?.statusCode == 205
                completion(success)
        })
    }

    func markNotificationRead(id: String) {
        _localReadIDs.insert(id)

        for wrapper in listeners {
            if let listener = wrapper.listener {
                listener.willMarkRead(client: self, id: id)
            }
        }

        githubClient.request(GithubClient.Request(
            path: "notifications/threads/\(id)",
            method: .put) { response in
                // https://developer.github.com/v3/activity/notifications/#mark-a-thread-as-read
                let success = response.response?.statusCode == 205
                if !success {
                    // remove so lists can re-show the notification
                    self._localReadIDs.remove(id)

                    for wrapper in self.listeners {
                        if let listener = wrapper.listener {
                            listener.didFailToMarkRead(client: self, id: id)
                        }
                    }
                }
        })
    }

}
