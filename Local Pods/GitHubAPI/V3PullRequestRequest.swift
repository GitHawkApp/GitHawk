//
//  V3PullRequestRequest.swift
//  GitHubAPI
//
//  Created by Yury Bogdanov on 13/03/2018.
//

import Foundation

public struct V3PullRequest: Codable {
    public struct Branch: Codable {
        public let ref: String
    }
    
    public let base: Branch
    public let head: Branch
}

public struct V3PullRequestResponse: EntityResponse {
    public let data: V3PullRequest
    
    public typealias InputType = Data
    public typealias OutputType = V3PullRequest
    
    public init(input: InputType, response: HTTPURLResponse?) throws {
        self.data = try JSONDecoder().decode(V3PullRequest.self, from: input)
    }
}

public struct V3PullRequestRequest: V3Request {
    public typealias ResponseType = V3PullRequestResponse
    public var pathComponents: [String] {
        return ["repos", owner, repo, "pulls", "\(number)"]
    }
    
    public let owner: String
    public let repo: String
    public let number: Int
    
    public init(owner: String, repo: String, number: Int) {
        self.owner = owner
        self.repo = repo
        self.number = number
    }
}
