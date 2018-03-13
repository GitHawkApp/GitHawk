//
//  V3PullRequestRequest.swift
//  GitHubAPI
//
//  Created by Yury Bogdanov on 13/03/2018.
//

import Foundation

public struct V3PullRequestRequest: V3Request {
    public typealias ResponseType = JSONResponse<[String: Any]>
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
