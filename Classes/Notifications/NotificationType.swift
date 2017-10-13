//
//  NotificationType.swift
//  GitHawk
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
}

extension NotificationType {
    
    var localizedString: String {
        switch self {
        case .issue, .commit:
            return NSLocalizedString(self.rawValue, comment: "")
        case .pullRequest:
            return NSLocalizedString("Pull request", comment: "")
        }
    }
}
