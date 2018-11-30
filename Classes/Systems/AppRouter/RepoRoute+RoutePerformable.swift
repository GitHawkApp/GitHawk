//
//  RepoRoute+RoutePerformable.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/21/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHawkRoutes
import GitHubSession

extension RepoRoute: RoutePerformable {
    func perform(props: RoutePerformableProps) -> RoutePerformableResult {
        let model = RepositoryDetails(
            owner: owner,
            name: repo
        )
        return .push(RepositoryViewController(client: props.client, repo: model))
    }
}
