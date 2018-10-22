//
//  V3EditIssueTitleRequest.swift
//  GitHubAPI-iOS
//
//  Created by B_Litwin on 10/27/18.
//

import Foundation

public struct V3EditIssueTitleRequest: V3Request {
    public typealias ResponseType = V3StatusCodeResponse<V3StatusCode200>
    
    public var pathComponents: [String] {
        return ["repos", owner, repo, "issues", "\(issueNumber)"]
    }
    
    public var method: HTTPMethod { return .patch }
    public var parameters: [String : Any]? { return ["title": title] }
    
    public let owner: String
    public let repo: String
    public let issueNumber: Int
    public let title: String
    
    public init(owner: String, repo: String, issueNumber: Int, title: String) {
        self.owner = owner
        self.repo = repo
        self.issueNumber = issueNumber
        self.title = title
    }
}
