//
//  Alamofire+GitHub.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Alamofire

struct GithubRequest {
    let path: String
    let method: HTTPMethod
    let parameters: Parameters?
    let headers: HTTPHeaders?
    let completion: (DataResponse<Any>) -> Void
    let session: GithubSession?

    init(
        path: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        session: GithubSession? = nil,
        completion: @escaping (DataResponse<Any>) -> Void
        ) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.session = session
        self.completion = completion
    }
}

func request(
    _ request: GithubRequest
    ) -> DataRequest {
    print("Requesting: " + request.path)

    let encoding: ParameterEncoding
    switch request.method {
    case .get: encoding = URLEncoding.queryString
    default: encoding = JSONEncoding.default
    }

    var parameters = request.parameters ?? [:]
    if let authorization = request.session?.authorization {
        parameters["access_token"] = authorization.token
    }

    return Alamofire.request("https://api.github.com/" + request.path,
                             method: request.method,
                             parameters: parameters,
                             encoding: encoding,
                             headers: request.headers)
        .responseJSON(completionHandler: { response in
            print(response.response ?? "")
            print(response.value ?? response.error?.localizedDescription ?? "Unknown error")

            // remove the github session if requesting with a session
            if let session = request.session,
                let statusCode = response.response?.statusCode,
                (statusCode == 401 || statusCode == 403) {
                session.remove()
            } else {
                request.completion(response)
            }
        })
}
