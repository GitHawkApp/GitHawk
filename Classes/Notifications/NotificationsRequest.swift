//
//  NotificationsRequest.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

enum NotificationResult {
    case failed(Error?)
    case success([Notification])
}

extension GithubClient {

    func requestNotifications(
        all: Bool = false,
        participating: Bool = false,
        since: Date? = nil,
        page: Int = 0,
        before: Date? = nil,
        completion: @escaping (NotificationResult) -> ()
        ) {
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
            request(Request(
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

}
