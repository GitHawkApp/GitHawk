//
//  V3Content.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public enum V3ContentError: Error {
    case badData
}

public struct V3Content: Codable {
    public let content: String
    public let url: URL

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let content = try container.decode(String.self, forKey: .content)
        guard let data = Data(base64Encoded: content, options: [.ignoreUnknownCharacters]),
            let str = String(data: data, encoding: .utf8)
            else {
                throw V3ContentError.badData
        }
        self.content = str
        self.url = try container.decode(URL.self, forKey: .url)
    }
}
