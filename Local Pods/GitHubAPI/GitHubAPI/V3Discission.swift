//
//  V3Discission.swift
//  GitHubAPI
//
//  Created by Bas Broek on 28/07/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3Discussion: Codable {

    public let number: Int
    public let author: V3User
    public let title: String

    /// The body of the original post of the discussion.
    ///
    /// - Note: This returns an HTML-string of the body.
    public let body: String
    public let commentsCount: Int
    public var hasComments: Bool { return commentsCount != 0 }
    public let isPinned: Bool
    public let isPrivate: Bool
    public let createdAt: Date
    public let webURL: URL

    enum CodingKeys: String, CodingKey {
        case number
        case author
        case title
        case body = "body_html"
        case commentsCount = "comments_count"
        case isPinned = "pinned"
        case isPrivate = "private"
        case createdAt = "created_at"
        case webURL = "html_url"
    }

}
