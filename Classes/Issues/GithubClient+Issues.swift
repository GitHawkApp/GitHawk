//
//  GithubClient+Issues.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

extension GithubClient {

    func fetch(
        owner: String,
        repo: String,
        number: Int,
        pullRequest: Bool,
        width: CGFloat,
        completion: @escaping ([IGListDiffable]) -> ()
        ) {
        if pullRequest {
            let query = PullRequestQuery(owner: owner, repo: repo, number: number)
            apollo.fetch(query: query) { (result, error) in
                if let pullRequest = result?.data?.repository?.pullRequest {
                    createViewModels(pullRequest: pullRequest, width: width) { results in
                        completion(results)
                    }
                } else {
                    completion([])
                }
            }
        } else {
            let query = IssueQuery(owner: owner, repo: repo, number: number)
            apollo.fetch(query: query) { (result, error) in
                if let issue = result?.data?.repository?.issue {
                    createViewModels(issue: issue, width: width) { results in
                        completion(results)
                    }
                } else {
                    completion([])
                }
            }
        }
    }

}
