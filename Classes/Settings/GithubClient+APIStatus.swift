//
//  GithubClient+APIStatus.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/27/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension GithubClient {

    enum APIStatus: String {
        case good = "good"
        case minor = "minor"
        case major = "major"
    }

    func fetchAPIStatus(completion: @escaping (Result<APIStatus>) -> ()) {
        request(Request(
            url: "https://status.github.com/api/status.json",
            method: .get,
            completion: { (response, _) in
                if let json = response.value as? [String: Any],
                    let statusString = json["status"] as? String,
                    let status = APIStatus(rawValue: statusString) {
                    completion(.success(status))
                } else {
                    completion(.error(nil))
                }
        }))
    }

}
