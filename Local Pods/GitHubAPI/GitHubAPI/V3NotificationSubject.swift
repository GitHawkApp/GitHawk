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
    }

    public let title: String
    public let type: SubjectType
    public let url: URL?

}

public extension V3NotificationSubject {

    enum Identifier {
        case number(Int)
        case hash(String)
        case release(String)
    }

    var identifier: Identifier? {
        guard let url = self.url else { return nil }
        let split = url.absoluteString.components(separatedBy: "/")

        guard split.count > 2,
            let identifier = split.last
            else { return nil }
        
        let type = split[split.count - 2]
        switch type {
        case "commits":
            return .hash(identifier)
        case "releases":
            return .release(identifier)
        default:
            return .number((identifier as NSString).integerValue)
        }
    }

}
