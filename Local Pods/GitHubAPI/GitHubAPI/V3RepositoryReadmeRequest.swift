//
//  V3RepositoryReadmeRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public enum V3RepositoryContentError: Error {
    case badData
}

public struct V3RepositoryReadme: Codable {
    public let content: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let content = try container.decode(String.self, forKey: .content)
        guard let data = Data(base64Encoded: content, options: [.ignoreUnknownCharacters]),
            let str = String(data: data, encoding: .utf8)
            else {
                throw V3RepositoryContentError.badData
        }
        self.content = str
    }
}

public struct V3RepositoryReadmeRequest: V3Request {
    public typealias ResponseType = V3DataResponse<V3RepositoryReadme>
    public var pathComponents: [String] {
        return ["repos", owner, repo, "readme"]
    }

    public let owner: String
    public let repo: String

    public init(owner: String, repo: String) {
        self.owner = owner
        self.repo = repo
    }
}
