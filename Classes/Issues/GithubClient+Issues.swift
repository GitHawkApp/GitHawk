//
//  GithubClient+Issues.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

enum IssueResult {
    case success(Issue)
    case failure(Error?)
}

extension GithubClient {

    func requestIssue(
        owner: String,
        repo: String,
        number: String,
        completion: @escaping (IssueResult) -> ()
        ) {
        // fetch issues
        // fetch comments
        // fetch events

        // https://developer.github.com/v3/issues/#reactions-summary-2
        let headers = [
            "Accept": "application/vnd.github.squirrel-girl-preview"
        ]

        request(Request(
            path: "/repos/\(owner)/\(repo)/issues/\(number)",
            method: .get,
            parameters: nil,
            headers: headers
        ) { response in
            if let json = response.value as? [String: Any],
                let issue = Issue(json: json) {
                completion(.success(issue))
            } else {
                completion(.failure(response.error))
            }
        })
    }
    
}
