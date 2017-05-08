//
//  Alamofire+GitHub.swift
//  Gitter
//
//  Created by Ryan Nystrom on 5/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Alamofire

func requestGithub(
    path: String,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil,
    headers: HTTPHeaders? = nil,
    completion: @escaping (DataResponse<Any>) -> Void
    ) -> DataRequest {
    print("Requesting: " + path)
    return Alamofire.request("https://api.github.com/" + path,
                             method: method,
                             parameters: parameters,
                             encoding: URLEncoding.methodDependent,
                             headers: headers)
        .responseJSON(completionHandler: { response in
            print(response.response ?? "")
            print(response.value ?? response.error?.localizedDescription ?? "Unknown error")
            completion(response)
        })
}
