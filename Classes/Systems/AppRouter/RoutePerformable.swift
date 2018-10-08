//
//  RoutePerformable.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubSession

protocol RoutePerformable {
    @discardableResult
    func perform(
        sessionManager: GitHubSessionManager,
        splitViewController: AppSplitViewController
    ) -> Bool
}
