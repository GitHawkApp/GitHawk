//
//  NotificationClient.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/30/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

// used to request states via graphQL
extension NotificationViewModel {
    var stateAlias: (number: Int, key: String)? {
        switch identifier {
        case .hash, .release:
            // commits and releases don't have states, always "merged"
            return nil
        case .number(let number):
            // graphQL alias must be an alpha-numeric string and start w/ alpha
            return (number, "k\(id)")
        }
    }
}

final class NotificationClient {

    struct NotificationRepository {
        let owner: String
        let name: String
    }

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
        repo: NotificationRepository? = nil,
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

        githubClient.request(GithubClient.Request(
            path: path(repo: repo),
            method: .get,
            parameters: parameters,
            headers: nil
        ) { response, nextPage in
            if let notifications = (response.value as? [[String:Any]])?.flatMap({ NotificationResponse(json: $0) }) {
                let viewModels = CreateViewModels(containerWidth: width, notifications: notifications)
                self.fetchStates(for: viewModels, page: nextPage?.next, completion: completion)
            } else {
                completion(.error(response.error))
            }
        })
    }

    private func fetchStates(
        for notifications: [NotificationViewModel],
        page: Int?,
        completion: @escaping (Result<([NotificationViewModel], Int?)>) -> Void
        ) {

        let content = "state comments{totalCount}"
        let notificationQueries: String = notifications.flatMap {
            guard let alias = $0.stateAlias else { return nil }
            return """
            \(alias.key): repository(owner: "\($0.owner)", name: "\($0.repo)") { issueOrPullRequest(number: \(alias.number)) { ...on Issue {\(content)} ...on PullRequest {\(content)} } }
            """
            }.joined(separator: " ")
        let query = "query{\(notificationQueries)}"

        let cache = githubClient.cache

        githubClient.graphQL(
        parameters: ["query": query]) { response in
            let processedNotifications: [NotificationViewModel]
            if let json = response.value as? [String: Any],
                let data = json["data"] as? [String: Any] {

                var updatedNotifications = [NotificationViewModel]()
                for notification in notifications {
                    if let alias = notification.stateAlias,
                        let result = data[alias.key] as? [String: Any],
                        let issueOrPullRequest = result["issueOrPullRequest"] as? [String: Any],
                        let stateString = issueOrPullRequest["state"] as? String,
                        let state = NotificationViewModel.State(rawValue: stateString),
                    let commentsJSON = issueOrPullRequest["comments"] as? [String: Any],
                    let commentCount = commentsJSON["totalCount"] as? Int {
                        updatedNotifications.append(notification.updated(state: state, commentCount: commentCount))
                    } else {
                        updatedNotifications.append(notification)
                    }
                }

                processedNotifications = updatedNotifications
            } else {
                processedNotifications = notifications
            }
            cache.set(values: processedNotifications)
            completion(.success((processedNotifications, page)))
        }

    }

    func markAllNotifications(completion: @escaping (Bool) -> Void) {
        markNotifications(repo: nil, completion: completion)
    }

    func markRepoNotifications(repo: NotificationRepository, completion: @escaping (Bool) -> Void) {
        markNotifications(repo: repo, completion: completion)
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
                githubClient.cache.set(value: old.updated(read: true))
            }
        }

        githubClient.request(GithubClient.Request(
            path: "notifications/threads/\(id)",
            method: .patch) { [weak self] response, _ in
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
        ) { response, _ in
            // https://developer.github.com/v3/activity/watching/#list-repositories-being-watched
            if let jsonArr = response.value as? [ [String: Any] ] {
                var repos = [Repository]()
                for json in jsonArr {
                    if let repo = Repository(json: json) {
                        repos.append(repo)
                    }
                }
                completion(.success(repos.sorted { $0.name < $1.name }))
            } else {
                completion(.error(response.error))
            }
        })
    }

    // MARK: Private API

    func path(repo: NotificationRepository?) -> String {
        if let repo = repo {
            return "repos/\(repo.owner)/\(repo.name)/notifications"
        } else {
            return "notifications"
        }
    }

    func markNotifications(repo: NotificationRepository? = nil, completion: @escaping (Bool) -> Void) {
        githubClient.request(GithubClient.Request(
            path: path(repo: repo),
            method: .put
        ) { response, _ in
            let success = response.response?.statusCode == 205
            completion(success)
        })
    }

}
