//
//  NotificationClient.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/30/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class NotificationClient {

    private var openedNotificationIDs = Set<String>()

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

    // https://developer.github.com/v3/activity/notifications/#list-your-notifications
    func requestNotifications(
        all: Bool = false,
        participating: Bool = false,
        since: Date? = nil,
        page: Int = 1,
        before: Date? = nil,
        width: CGFloat,
        completion: @escaping (Result<([NotificationViewModel], Int?)>) -> Void
        ) {
        var parameters: [String: Any] = [
            "all": all ? "true" : "false",
            "participating": participating ? "true" : "false",
            "page": page,
            "per_page": "50"
            ]
        if let since = since {
            parameters["since"] = GithubAPIDateFormatter().string(from: since)
        }
        if let before = before {
            parameters["before"] = GithubAPIDateFormatter().string(from: before)
        }

        let cache = githubClient.cache

        githubClient.request(GithubClient.Request(
            client: githubClient.userSession?.client,
            path: "notifications",
            method: .get,
            parameters: parameters,
            headers: nil
        ) { (response, nextPage) in
            if let notifications = (response.value as? [[String:Any]])?.flatMap({ NotificationResponse(json: $0) }) {
                let viewModels = CreateViewModels(containerWidth: width, notifications: notifications)
                cache.set(values: viewModels)
                completion(.success((viewModels, nextPage?.next)))
            } else {
                completion(.error(response.error))
            }
        })
    }

    typealias MarkAllCompletion = (Bool) -> Void
    func markAllNotifications(completion: MarkAllCompletion? = nil) {
        githubClient.request(GithubClient.Request(
            client: githubClient.userSession?.client,
            path: "notifications",
            method: .put) { (response, _) in
                guard let completion = completion else { return }
                // https://developer.github.com/v3/activity/notifications/#mark-as-read
                let success = response.response?.statusCode == 205
                completion(success)
        })
    }

    func notificationOpened(id: String) -> Bool {
        return openedNotificationIDs.contains(id)
    }

    func markNotificationRead(id: String, isOpen: Bool) {
        let oldModel = githubClient.cache.get(id: id) as NotificationViewModel?

        if isOpen {
            openedNotificationIDs.insert(id)
        } else {
            // optimistically set the model to read
            // if the request fails, replace this model w/ the old one.
            if let old = oldModel {
                githubClient.cache.set(value: NotificationViewModel(
                    id: old.id,
                    title: old.title,
                    type: old.type,
                    date: old.date,
                    read: true,
                    owner: old.owner,
                    repo: old.repo,
                    identifier: old.identifier
                ))
            }
        }

        githubClient.request(GithubClient.Request(
            client: githubClient.userSession?.client,
            path: "notifications/threads/\(id)",
            method: .patch) { [weak self] (response, _) in
                // https://developer.github.com/v3/activity/notifications/#mark-a-thread-as-read
                if response.response?.statusCode != 205 {
                    if isOpen {
                        self?.openedNotificationIDs.remove(id)
                    } else if let old = oldModel {
                        self?.githubClient.cache.set(value: old)
                    }
                }
        })
    }

}
