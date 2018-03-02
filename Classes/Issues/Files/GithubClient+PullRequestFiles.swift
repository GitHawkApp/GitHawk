//
//  GitHubClient+PullRequestFiles.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension GithubClient {

    func fetchFiles(
        owner: String,
        repo: String,
        number: Int,
        page: Int,
        completion: @escaping (Result<([File], Int?)>) -> Void
        ) {
        request(Request.api(
            path: "repos/\(owner)/\(repo)/pulls/\(number)/files",
            parameters: [
                "per_page": 50,
                "page": page
            ],
            completion: { (response, nextPage) in
                if let arr = response.value as? [ [String: Any] ] {
                    var files = [File]()
                    for json in arr {
                        if let file = File(json: json) {
                            files.append(file)
                        }
                    }
                    completion(.success((files, nextPage?.next)))
                } else {
                    completion(.error(nil))
                }
        }))
    }
}
