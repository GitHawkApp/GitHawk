//
//  V3Milestone.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3Milestone: Codable {

    public let creator: V3User
    public let createdAt: Date
    public let closedIssues: Int
    public let closedAt: Date?
    public let description: String?
    public let dueOn: Date?
    public let id: Int
    public let number: Int
    public let openIssues: Int
    public let updatedAt: Date
    public let title: String

    enum CodingKeys: String, CodingKey {
        case creator
        case createdAt = "created_at"
        case closedIssues = "closed_issues"
        case closedAt = "closed_at"
        case description
        case dueOn = "due_on"
        case id
        case number = "number"
        case openIssues = "open_issues"
        case updatedAt = "updated_at"
        case title
    }

}
