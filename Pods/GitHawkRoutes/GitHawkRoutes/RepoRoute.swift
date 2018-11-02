//
//  RepoRoute.swift
//  GitHawkRoutes
//
//  Created by Ryan Nystrom on 10/21/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct RepoRoute: Routable {

    public let owner: String
    public let repo: String
    public let branch: String

    public init(owner: String, repo: String, branch: String) {
        self.owner = owner
        self.repo = repo
        self.branch = branch
    }

    public static func from(params: [String: String]) -> RepoRoute? {
        guard let owner = params["owner"],
            let repo = params["repo"],
            let branch = params["branch"]
            else { return nil }
        return RepoRoute(owner: owner, repo: repo, branch: branch)
    }

    public static var path: String {
        return "com.githawk.repo"
    }

    public var encoded: [String: String] {
        return [
            "owner": owner,
            "repo": repo,
            "branch": branch
        ]
    }

}
