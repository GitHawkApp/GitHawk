//
//  NotificationClient.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/30/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

import GitHubAPI

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
        page: Int = 1,
        width: CGFloat,
        completion: @escaping (Result<([NotificationViewModel], Int?)>) -> Void
        ) {
        if let repo = repo {
            githubClient.client.send(V3RepositoryNotificationRequest(all: all, owner: repo.owner, repo: repo.name)) { result in
                switch result {
                case .success(let response):
                    let viewModels = CreateViewModels(containerWidth: width, v3notifications: response.data)
                    self.fetchStates(for: viewModels, page: response.next, completion: completion)
                case .failure(let error):
                    completion(.error(error))
                }
            }
        } else {
            githubClient.client.send(V3NotificationRequest(all: all, page: page)) { result in
                switch result {
                case .success(let response):
                    let viewModels = CreateViewModels(containerWidth: width, v3notifications: response.data)
                    self.fetchStates(for: viewModels, page: response.next, completion: completion)
                case .failure(let error):
                    completion(.error(error))
                }
            }
        }
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

        githubClient.client.send(ManualGraphQLRequest(query: query)) { result in
            let processedNotifications: [NotificationViewModel]
            switch result {
            case .success(let json):
                var updatedNotifications = [NotificationViewModel]()
                for notification in notifications {
                    if let alias = notification.stateAlias,
                        let result = json.data[alias.key] as? [String: Any],
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
            case .failure:
                processedNotifications = notifications
            }
            cache.set(values: processedNotifications)
            completion(.success((processedNotifications, page)))
        }
    }

    func markAllNotifications(completion: @escaping (Bool) -> Void) {
        githubClient.client.send(V3MarkNotificationsRequest()) { result in
            switch result {
            case .success: completion(true)
            case .failure: completion(false)
            }
        }
    }

    func markRepoNotifications(repo: NotificationRepository, completion: @escaping (Bool) -> Void) {
        githubClient.client.send(V3MarkRepositoryNotificationsRequest(owner: repo.owner, repo: repo.name)) { result in
            switch result {
            case .success: completion(true)
            case .failure: completion(false)
            }
        }
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

        githubClient.client.send(V3MarkThreadsRequest(id: id)) { [weak self] result in
            switch result {
            case .success: break
            case .failure:
                if isOpen {
                    self?.openedNotificationIDs.remove(id)
                } else if let old = oldModel {
                    self?.githubClient.cache.set(value: old)
                }
            }
        }
    }

}
