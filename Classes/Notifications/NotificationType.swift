//
//  NotificationType.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

// https://github.com/octokit/octokit.objc/blob/master/OctoKit/OCTNotification.m#L63-L65
enum NotificationType: String {
    case issue = "Issue"
    case pullRequest = "PullRequest"
    case commit = "Commit"
    case repo = "Repository"
    case release = "Release"
    case securityVulnerability = "RepositoryVulnerabilityAlert"
    case ci_activity = "CheckSuite"

    var localizedString: String {
        switch self {
        case .issue: return Constants.Strings.issue
        case .commit: return NSLocalizedString("Commit", comment: "")
        case .repo: return NSLocalizedString("Repository", comment: "")
        case .release: return NSLocalizedString("Release", comment: "")
        case .pullRequest: return Constants.Strings.pullRequest
        case .securityVulnerability: return NSLocalizedString("Security Vulnerability", comment: "")
        case .ci_activity: return NSLocalizedString("CI Activity", comment: "")
        }
    }
}

extension NotificationType: Codable { }
