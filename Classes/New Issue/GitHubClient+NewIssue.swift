//
//  GitHubClient+NewIssue.swift
//  Freetime
//
//  Created by Sherlock, James on 15/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Alamofire

extension GithubClient {

    func createIssue(owner: String, repo: String, title: String, body: String?, completion: @escaping (IssueDetailsModel?) -> Void) {

        let params = [
            "title": title,
            "body": body ?? ""
        ]

        let networkCompletion: ((DataResponse<Any>, GithubClient.Page?) -> Void) = { (response, _) in
            guard let dict = response.value as? [String: Any], let number = dict["number"] as? Int else {
                completion(nil)
                return
            }

            let model = IssueDetailsModel(owner: owner, repo: repo, number: number)
            completion(model)
        }

        request(Request(path: "repos/\(owner)/\(repo)/issues",
                        method: .post,
                        parameters: params,
                        headers: nil,
                        logoutOnAuthFailure: false,
                        completion: networkCompletion))
    }

}
