//
//  RoutePerformable.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import GitHubSession

enum RoutePerformableResult {
    case error
    case custom
    case push(UIViewController)
    case setDetail(UIViewController)
    case present(UIViewController)

    var wasHandled: Bool {
        switch self {
        case .error: return false
        default: return true
        }
    }
}

struct RoutePerformableProps {
    let sessionManager: GitHubSessionManager
    let splitViewController: AppSplitViewController
    let client: GithubClient
}

protocol RoutePerformable {
    func perform(props: RoutePerformableProps) -> RoutePerformableResult
}
