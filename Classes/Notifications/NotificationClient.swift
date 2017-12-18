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
    func fetchNotifications(
        repo: (owner: String, name: String)? = nil,
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

        let path: String
        if let repo = repo {
            path = "/repos/\(repo.owner)/\(repo.name)/notifications"
        } else {
            path = "notifications"
        }

        let cache = githubClient.cache

        githubClient.request(GithubClient.Request(
            path: path,
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

    func markAllNotifications(completion: @escaping (Bool) -> Void) {
        markNotifications(repo: nil, completion: completion)
    }

    func markRepoNotifications(owner: String, repo: String, completion: @escaping (Bool) -> Void) {
        markNotifications(repo: (owner, repo), completion: completion)
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

    func fetchWatchedRepositories(completion: @escaping (Result<[Repository]>) -> Void) {
        guard let viewer = githubClient.userSession?.username else {
            completion(.error(nil))
            return
        }

        githubClient.request(GithubClient.Request(
            path: "users/\(viewer)/subscriptions"
        ) { (response, _) in
            // https://developer.github.com/v3/activity/watching/#list-repositories-being-watched
            if let jsonArr = response.value as? [ [String: Any] ] {
                var repos = [Repository]()
                for json in jsonArr {
                    if let repo = Repository(json: json) {
                        repos.append(repo)
                    }
                }
                completion(.success(repos))
            } else {
                completion(.error(response.error))
            }
        })
    }

    // MARK: Private API

    func markNotifications(repo: (owner: String, name: String)?, completion: @escaping (Bool) -> Void) {
        let path: String
        if let repo = repo {
            // https://developer.github.com/v3/activity/notifications/#mark-notifications-as-read-in-a-repository
            path = "/repos/\(repo.owner)/\(repo.name)/notifications"
        } else {
            // https://developer.github.com/v3/activity/notifications/#mark-as-read
            path = "notifications"
        }

        githubClient.request(GithubClient.Request(
            path: path,
            method: .put
        ) { (response, _) in
            let success = response.response?.statusCode == 205
            completion(success)
        })
    }

}
