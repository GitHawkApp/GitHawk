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
        case good, minor, major
    }

    func fetchAPIStatus(completion: @escaping (Result<APIStatus>) -> Void) {
        
        guard let url = userSession?.client.statusAPIUrl else {
            return
        }
        
        request(Request(
            url: url,
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
