//
//  IssueNotificationRoute.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/9/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct IssueRoute: Routable {

    public let owner: String
    public let repo: String
    public let number: Int
    public let scrollToBottom: Bool

    public init(owner: String, repo: String, number: Int, scrollToBottom: Bool = false) {
        self.owner = owner
        self.repo = repo
        self.number = number
        self.scrollToBottom = scrollToBottom
    }

    public static func from(params: [String: String]) -> IssueRoute? {
        guard let owner = params["owner"],
            let repo = params["repo"],
            let number = (params["number"] as NSString?)?.integerValue
            else { return nil }
        // optional to handle migrations
        let scrollToBottom = (params["scrollToBottom"] as NSString?)?.boolValue ?? false
        return IssueRoute(
            owner: owner,
            repo: repo,
            number: number,
            scrollToBottom: scrollToBottom
        )
    }

    public var encoded: [String: String] {
        return [
            "owner": owner,
            "repo": repo,
            "number": "\(number)",
            "scrollToBottom": "\(scrollToBottom)"
        ]
    }
    
}
