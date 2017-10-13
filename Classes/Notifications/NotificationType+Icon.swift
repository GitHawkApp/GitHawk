//
//  NotificationType+Icon.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension NotificationType {

    var icon: UIImage? {
        let name: String
        switch self {
        case .commit: name = "git-commit"
        case .issue: name = "issue-opened"
        case .pullRequest: name = "git-pull-request"
        }
        return UIImage(named: name)
    }

}
