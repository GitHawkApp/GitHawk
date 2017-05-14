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
    case noauth
    case success([Notification])
}

fileprivate let dateFormatter = DateFormatter()

func requestNotifications(
    session: GithubSession,
    all: Bool = false,
    participating: Bool = false,
    since: Date = Date(),
    page: Int = 0,
    before: Date? = nil,
    completion: (NotificationResult) -> ()
    ) {
    dateFormatter.dateFormat = ""

    var parameters: [String: Any] = [
        "all": all ? "true" : "false",
        "participating": participating ? "true" : "false",
        "since": dateFormatter.string(from: since),
        "page": page,
        ]
    if let before = before {
        parameters["before"] = dateFormatter.string(from: before)
    }

    let r = GithubRequest(
        path: "notifications",
        method: .get,
        parameters: parameters,
        headers: nil,
        session: session) { response in
            print(response)
    }

    request(r)
}
