//
//  GithubClient+Milestones.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension GithubClient {

    func fetchMilestones(
        owner: String,
        repo: String,
        completion: @escaping (Result<[Milestone]>) -> Void
        ) {
        request(GithubClient.Request(
            path: "repos/\(owner)/\(repo)/milestones"
        ) { (response, _) in
            if let jsonArr = response.value as? [[String: Any]] {
                var milestones = [Milestone]()
                for json in jsonArr {
                    if let milestone = Milestone(json: json) {
                        milestones.append(milestone)
                    }
                }
                completion(.success(milestones))
            } else {
                completion(.error(response.error))
            }
        })
    }

}
