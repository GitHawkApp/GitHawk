//
//  GitHubClient+PullRequestFiles.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension GithubClient {

    enum FileResult {
        case success([File])
        case error
    }

    func fetchFiles(
        owner: String, 
        repo: String,
        number: Int,
        completion: @escaping (FileResult) -> ()) {
        request(Request(
            path: "repos/\(owner)/\(repo)/pulls/\(number)/files",
            completion: { (response, _) in
                if let arr = response.value as? [ [String: Any] ] {
                    var files = [File]()
                    for json in arr {
                        if let file = File(json: json) {
                            files.append(file)
                        }
                    }
                    completion(.success(files))
                } else {
                    completion(.error)
                }
        }))
    }

}
