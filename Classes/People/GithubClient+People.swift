//
//  GithubClient+People.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension GithubClient {

    func fetchAssignees(
        owner: String,
        repo: String,
        completion: @escaping (Result<[User]>) -> Void
        ) {
        // https://developer.github.com/v3/issues/assignees/#list-assignees
        request(GithubClient.Request(
            client: userSession?.client,
            path: "repos/\(owner)/\(repo)/assignees"
        ) { (response, _) in
            if let jsonArr = response.value as? [[String: Any]] {
                var users = [User]()
                for json in jsonArr {
                    if let user = User(json: json) {
                        users.append(user)
                    }
                }
                users.sort { $0.login.lowercased() < $1.login.lowercased() }
                completion(.success(users))
            } else {
                completion(.error(response.error))
            }
        })
    }

}
