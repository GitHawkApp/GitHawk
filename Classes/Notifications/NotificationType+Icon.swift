//
//  NotificationType+Icon.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension NotificationType {
    func icon(merged: Bool = false) -> UIImage? {
        if merged {
            return UIImage(named: "git-merge")
        }
        let name: String
        switch self {
        case .repo: name = "repo"
        case .commit: name = "git-commit"
        case .issue: name = "issue-opened"
        case .pullRequest: name = "git-pull-request"
        case .release: name = "tag"
        case .securityVulnerability: name = "alert"
        case .ci_activity: name = "actions"
        }
        return UIImage(named: name)
    }
}
