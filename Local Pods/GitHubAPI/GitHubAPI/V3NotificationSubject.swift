//
//  V3NotificationSubject.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3NotificationSubject: Codable {

    public enum SubjectType: String, Codable {
        case issue = "Issue"
        case pullRequest = "PullRequest"
        case commit = "Commit"
        case repo = "Repository"
        case release = "Release"
        case invitation = "RepositoryInvitation"
        case vulnerabilityAlert = "RepositoryVulnerabilityAlert"
    }

    public let title: String
    public let type: SubjectType
    public let url: URL?

}
