//
//  V3Issue.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 12/2/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3Issue: Codable {
    public let status: String
    public let changes: Int
    public let filename: String
    public let additions: Int
    public let deletions: Int
    public let sha: String
    public let patch: String?
}
