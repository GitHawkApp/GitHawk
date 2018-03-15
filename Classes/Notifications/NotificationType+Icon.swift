//
//  NotificationType+Icon.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension NotificationType {
    var icon: UIImage {
        let image: UIImage

        switch self {
        case .repo: image = #imageLiteral(resourceName: "repo")
        case .commit: image = #imageLiteral(resourceName: "git-commit")
        case .issue: image = #imageLiteral(resourceName: "issue-opened")
        case .pullRequest: image = #imageLiteral(resourceName: "git-pull-request")
        case .release: image = #imageLiteral(resourceName: "tag")
        }

        return image
    }
}
