//
//  V3Milestone.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

struct V3Milestone: Codable {

    let creator: V3User
    let createdAt: Date
    let closedIssues: Int
    let closedAt: Date?
    let description: String
    let dueOn: Date?
    let id: Int
    let number: Int
    let openIssues: Int
    let updatedAt: Date

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
    }

}
