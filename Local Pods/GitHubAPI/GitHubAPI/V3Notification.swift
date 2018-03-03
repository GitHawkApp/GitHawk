//
//  V3Notification.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3Notification: Codable {

    enum Reason: String, Codable {
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

    let id: String
    let lastReadAt: Date?
    let reason: Reason
    let repository: V3Repository
    let subject: V3NotificationSubject
    let unread: Bool
    let updatedAt: Date

    enum CodingKeys : String, CodingKey {
        case id
        case lastReadAt = "last_read_at"
        case reason
        case repository
        case subject
        case unread
        case updatedAt = "updated_at"
    }

}
