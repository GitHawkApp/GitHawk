//
//  GithubClient+EditComment.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/16/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension GithubClient {

    func editComment(
        owner: String,
        repo: String,
        issueNumber: Int,
        commentID: Int,
        body: String,
        isRoot: Bool,
        completion: @escaping (Result<Bool>) -> Void
        ) {
        let path = isRoot
            // https://developer.github.com/v3/issues/#edit-an-issue
            ? "repos/\(owner)/\(repo)/issues/\(issueNumber)"
            // https://developer.github.com/v3/issues/comments/#edit-a-comment
            : "repos/\(owner)/\(repo)/issues/comments/\(commentID)"
        request(Request.api(
            path: path,
            method: .patch,
            parameters: ["body": body],
            completion: { (response, _) in
            if response.response?.statusCode == 200 {
                completion(.success(true))
            } else {
                completion(.error(response.error))
            }
        }))
    }

}
