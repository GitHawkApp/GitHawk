//
//  V3NotificationSubject.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3NotificationSubject: Codable {

    enum SubjectType: String, Codable {
        case release = "Release"
        case issue = "Issue"
        case pullRequest = "PullRequest"
        case commit = "Commit"
    }

    let title: String
    let type: SubjectType
    let url: URL

}
