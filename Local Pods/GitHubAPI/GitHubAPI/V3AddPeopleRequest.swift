//
//  V3AddPeopleRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3AddPeopleRequest: V3Request {

    public enum PeopleType {
        case assignees
        case reviewers
    }

    public typealias ResponseType = V3StatusCodeResponse<V3StatusCode200or201>
    public var pathComponents: [String] {
        let last: String
        let fourth: String
        switch type {
        case .assignees: last = "assignees"
            fourth = "issues"
        case .reviewers: last = "requested_reviewers"
            fourth = "pulls"
        }
        return ["repos", owner, repo, fourth, "\(number)", last]
    }
    public var parameters: [String : Any]? {
        let key: String
        switch type {
        case .assignees: key = "assignees"
        case .reviewers: key = "reviewers"
        }
        return [key: people]
    }
    public var method: HTTPMethod {
        return add ? .post : .delete
    }

    public let owner: String
    public let repo: String
    public let number: Int
    public let type: PeopleType
    public let add: Bool
    public let people: [String]

    public init(owner: String, repo: String, number: Int, type: PeopleType, add: Bool, people: [String]) {
        self.owner = owner
        self.repo = repo
        self.number = number
        self.type = type
        self.add = add
        self.people = people
    }
}
