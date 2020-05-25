//
//  NotificationClient2.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/9/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubAPI
import StyledTextKit

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

    private func handle(
        notifications: [V3Notification],
        next: Int?,
        width: CGFloat,
        contentSizeCategory: UIContentSizeCategory,
        completion: @escaping (Result<([NotificationViewModel], Int?)>) -> Void
        ) {
        githubClient.badge.updateLocalNotificationCache(
            notifications: notifications,
            showAlert: false
        )
        CreateNotificationViewModels(
            width: width,
            contentSizeCategory: contentSizeCategory,
            v3notifications: notifications
        ) { [weak self] in
            self?.fetchStates(for: $0, page: next, completion: completion)
        }
    }

    // https://developer.github.com/v3/activity/notifications/#list-your-notifications
    func fetchNotifications(
        repo: Repository? = nil,
        all: Bool = false,
        page: Int = 1,
        width: CGFloat,
        completion: @escaping (Result<([NotificationViewModel], Int?)>) -> Void
        ) {
        let contentSizeCategory = UIContentSizeCategory.preferred
        if let repo = repo {
            githubClient.client.send(V3RepositoryNotificationRequest(
                all: all,
                owner: repo.owner,
                repo: repo.name)
            ) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.handle(
                        notifications: response.data,
                        next: response.next,
                        width: width,
                        contentSizeCategory: contentSizeCategory,
                        completion: completion
                    )
                case .failure(let error):
                    completion(.error(error))
                }
            }
        } else {
            githubClient.client.send(V3NotificationRequest(all: all, page: page)) { [weak self] result in

                switch result {
                case .success(let response):
                    self?.handle(
                        notifications: response.data,
                        next: response.next,
                        width: width,
                        contentSizeCategory: contentSizeCategory,
                        completion: completion
                    )
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

        let content = "state comments{totalCount} viewerSubscription"
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
                        let commentCount = commentsJSON["totalCount"] as? Int,
                        let subscription = issueOrPullRequest["viewerSubscription"] as? String {
                        var newNotification = notification
                        newNotification.state = state
                        newNotification.comments = commentCount
                        newNotification.watching = subscription != "IGNORED"
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

    func markRepoNotifications(
        owner: String,
        name: String,
        completion: @escaping (Bool) -> Void
        ) {
        githubClient.client.send(V3MarkRepositoryNotificationsRequest(owner: owner, repo: name)) { result in
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

        githubClient.client.send(V3SubscribeThreadRequest(id: model.v3id, ignore: !model.watching)) { result in
            switch result {
            case .success:
                Haptic.triggerSelection()
            case .failure:
                Haptic.triggerNotification(.error)
                cache.set(value: notification)
            }
        }
    }

    enum DashboardType {
        case assigned
        case created
        case mentioned
    }

    func fetch(
        for type: DashboardType,
        page: Int,
        width: CGFloat,
        completion: @escaping (Result<([InboxDashboardModel], Int?)>) -> Void
        ) {
        let contentSizeCategory = UIApplication.shared.preferredContentSizeCategory
        let cache = githubClient.cache

        let mapped: V3IssuesRequest.FilterType
        switch type {
        case .assigned: mapped = .assigned
        case .mentioned: mapped = .mentioned
        case .created: mapped = .created
        }

        // Seems important
        githubClient.client.send(V3IssuesRequest(filter: mapped, page: page), completion: { result in
            // iterate result data, convert to InboxDashboardModel
            switch result {
            case .failure(let error):
                completion(.error(error))
            case .success(let data):
                let parsed: [InboxDashboardModel] = data.data.compactMap {
                    guard let state = NotificationViewModel.State(rawValue: $0.state.uppercased()) else {
                        return nil
                    }
                    let string = StyledTextBuilder(styledText: StyledText(
                        text: $0.title,
                        style: Styles.Text.body))
                        .build()
                    let text = StyledTextRenderer(
                        string: string,
                        contentSizeCategory: contentSizeCategory,
                        inset: InboxDashboardCell.inset
                    ).warm(width: width)
                    return InboxDashboardModel(
                        owner: $0.repository.owner.login,
                        name: $0.repository.name,
                        number: $0.number,
                        date: $0.updatedAt,
                        text: text,
                        isPullRequest: $0.pullRequest != nil,
                        state: state
                    )
                }
                cache.set(values: parsed)
                completion(.success((parsed, data.next)))
            }
        })
    }

}
