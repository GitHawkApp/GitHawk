//
//  V3Issue.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 12/2/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3Issue: Codable {

    public struct PullRequest: Codable {
        let url: URL
    }

//    public let id: Int
//    public let nodeId: String
    public let number: Int
    public let title: String
    public let state: String
//    public let createdAt: Date
    public let updatedAt: Date
    public let repository: V3Repository
//    public let comments: Int
    public let pullRequest: PullRequest?

    enum CodingKeys: String, CodingKey {
//        case id
//        case nodeId = "node_id"
        case number
        case title
        case state
//        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case repository
//        case comments
        case pullRequest = "pull_request"
    }

}
