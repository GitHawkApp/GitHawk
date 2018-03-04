//
//  V3ViewerIsCollaboratorRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3Permission: Codable {

    // https://developer.github.com/v3/repos/collaborators/#review-a-users-permission-level
    public enum Permission: String, Codable {
        case admin
        case write
        case read
        case none
    }

    public let permission: Permission

}

public struct V3ViewerIsCollaboratorResponse: EntityResponse {

    public let data: V3Permission.Permission

    public typealias InputType = Data
    public typealias OutputType = V3Permission.Permission

    public init(input: Data, response: HTTPURLResponse?) throws {
        if response?.statusCode == 403 {
            self.data = .none
        } else {
            self.data = try JSONDecoder().decode(V3Permission.self, from: input).permission
        }
    }
}

public struct V3ViewerIsCollaboratorRequest: V3Request {
    public typealias ResponseType = V3ViewerIsCollaboratorResponse
    public var pathComponents: [String] {
        return ["repos", owner, repo, "collaborators", viewer, "permission"]
    }
    public var headers: [String : String]? {
        return ["Accept": "application/vnd.github.hellcat-preview+json"]
    }
    public var method: HTTPMethod { return .patch }

    public let owner: String
    public let repo: String
    public let viewer: String

    public init(owner: String, repo: String, viewer: String) {
        self.owner = owner
        self.repo = repo
        self.viewer = viewer
    }
}
