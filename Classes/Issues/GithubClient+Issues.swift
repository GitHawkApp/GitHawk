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

        let block = { (issue: IssueType?) in
            if let issue = issue {
                DispatchQueue.global().async {
                    let result = createViewModels(issue: issue, width: width)
                    DispatchQueue.main.async {
                        completion(result)
                    }
                }
            } else {
                completion([])
            }
        }

        if pullRequest {
            let query = PullRequestQuery(owner: owner, repo: repo, number: number)
            apollo.fetch(query: query) { (result, error) in
                block(result?.data?.repository?.pullRequest)
            }
        } else {
            let query = IssueQuery(owner: owner, repo: repo, number: number)
            apollo.fetch(query: query) { (result, error) in
                block(result?.data?.repository?.issue)
            }
        }
    }

}
