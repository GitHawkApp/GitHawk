//
//  NotificationClient2.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/9/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubAPI

// used to request states via graphQL
extension NotificationViewModel {
    var stateAlias: (number: Int, key: String)? {
        switch number {
        case .hash, .release:
            // commits and releases don't have states, always "merged"
            return nil
        case .number(let number):
            // graphQL alias must be an alpha-numeric string and start w/ alpha
            return (number, "k\(id)")
        }
    }
}

final class NotificationModelController {

    let githubClient: GithubClient

    init(githubClient: GithubClient) {
        self.githubClient = githubClient
    }

    // Public API

    static private let openOnReadKey = "com.freetime.NotificationClient.read-on-open"

    static var readOnOpen: Bool {
        return UserDefaults.standard.bool(forKey: openOnReadKey)
    }

    static func setReadOnOpen(open: Bool) {
        UserDefaults.standard.set(open, forKey: openOnReadKey)
    }

    // https://developer.github.com/v3/activity/notifications/#list-your-notifications
    func fetchNotifications(
        repo: Repository? = nil,
        all: Bool = false,
        page: Int = 1,
        width: CGFloat,
        completion: @escaping (Result<([NotificationViewModel], Int?)>) -> Void
        ) {
        // hack to prevent double-fetching notifications when awaking from bg fetch
        guard UIApplication.shared.applicationState != .background else {
            // return success to avoid error states
            completion(.success(([], nil)))
            return
        }

        let badge = githubClient.badge
        let contentSizeCategory = UIContentSizeCategory.preferred
        // TODO move handling + parsing to a single method?
        if let repo = repo {
            githubClient.client.send(V3RepositoryNotificationRequest(all: all, owner: repo.owner, repo: repo.name)) { result in
                switch result {
                case .success(let response):
                    badge.updateLocalNotificationCache(notifications: response.data, showAlert: false)

                    CreateNotificationViewModels(
                        width: width,
                        contentSizeCategory: contentSizeCategory,
                        v3notifications: response.data
                    ) { [weak self] in
                        self?.fetchStates(for: $0, page: response.next, completion: completion)
                    }
                case .failure(let error):
                    completion(.error(error))
                }
            }
        } else {
            githubClient.client.send(V3NotificationRequest(all: all, page: page)) { result in
                switch result {
                case .success(let response):
                    badge.updateLocalNotificationCache(notifications: response.data, showAlert: false)
                    
                    CreateNotificationViewModels(
                        width: width,
                        contentSizeCategory: contentSizeCategory,
                        v3notifications: response.data
                    ) { [weak self] in
                        self?.fetchStates(for: $0, page: response.next, completion: completion)
                    }
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
        guard notifications.count > 0 else {
            completion(.success((notifications, page)))
            return
        }

        let content = "state comments{totalCount}"
        let notificationQueries: String = notifications.compactMap {
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
                        var newNotification = notification
                        newNotification.state = state
                        newNotification.comments = commentCount
                        updatedNotifications.append(newNotification)
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

    func markRepoNotifications(repo: Repository, completion: @escaping (Bool) -> Void) {
        githubClient.client.send(V3MarkRepositoryNotificationsRequest(owner: repo.owner, repo: repo.name)) { result in
            switch result {
            case .success: completion(true)
            case .failure: completion(false)
            }
        }
    }

    func markNotificationRead(id: String) {
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

    func toggleWatch(notification: NotificationViewModel) {
        let cache = githubClient.cache

        var model = notification
        model.watching = !notification.watching
        cache.set(value: model)

        githubClient.client.send(V3SubscribeThreadRequest(id: model.v3id, ignore: model.watching)) { result in
            switch result {
            case .success:
                Haptic.triggerSelection()
            case .failure:
                Haptic.triggerNotification(.error)
                cache.set(value: notification)
            }
        }
    }

}
