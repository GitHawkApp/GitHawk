//
//  V3Notification.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3Notification: Codable {

    public enum Reason: String, Codable {
        case assign = "assign"
        case author = "author"
        case comment = "comment"
        case invitation = "invitation"
        case manual = "manual"
        case mention = "mention"
        case stateChange = "state_change"
        case subscribed = "subscribed"
        case teamMention = "team_mention"
        case reviewRequested = "review_requested"
    }

    public let id: String
    public let lastReadAt: Date?
    public let reason: Reason
    public let repository: V3Repository
    public let subject: V3NotificationSubject
    public let unread: Bool
    public let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case lastReadAt = "last_read_at"
        case reason
        case repository
        case subject
        case unread
        case updatedAt = "updated_at"
    }

}
