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
        width: CGFloat,
        completion: @escaping ([IGListDiffable]) -> ()
        ) {

        let query = IssueOrPullRequestQuery(owner: owner, repo: repo, number: number, pageSize: 100)
        apollo.fetch(query: query) { (result, error) in
            let issueOrPullRequest = result?.data?.repository?.issueOrPullRequest
            if let issueType: IssueType = issueOrPullRequest?.asIssue ?? issueOrPullRequest?.asPullRequest {
                DispatchQueue.global().async {
                    let result = createViewModels(issue: issueType, width: width)
                    DispatchQueue.main.async {
                        completion(result)
                    }
                }
            } else {
                completion([])
            }
        }
    }

}
