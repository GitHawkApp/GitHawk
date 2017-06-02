//
//  GithubClient.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/16/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import Alamofire
import JDStatusBarNotification
import Apollo

struct GithubClient {

    struct Request {
        let path: String
        let method: HTTPMethod
        let parameters: Parameters?
        let headers: HTTPHeaders?
        let completion: (DataResponse<Any>) -> Void

        init(
            path: String,
            method: HTTPMethod = .get,
            parameters: Parameters? = nil,
            headers: HTTPHeaders? = nil,
            completion: @escaping (DataResponse<Any>) -> Void
            ) {
            self.path = path
            self.method = method
            self.parameters = parameters
            self.headers = headers
            self.completion = completion
        }
    }

    let sessionManager: GithubSessionManager
    let apollo: ApolloClient
    let networker: Alamofire.SessionManager
    let userSession: GithubUserSession?

    init(
        sessionManager: GithubSessionManager,
        apollo: ApolloClient,
        networker: Alamofire.SessionManager,
        userSession: GithubUserSession? = nil
        ) {
        self.sessionManager = sessionManager
        self.apollo = apollo
        self.networker = networker
        self.userSession = userSession
    }

    @discardableResult
    func request(
        _ request: GithubClient.Request
        ) -> DataRequest {
        print("Requesting: " + request.path)

        let encoding: ParameterEncoding
        switch request.method {
        case .get: encoding = URLEncoding.queryString
        default: encoding = JSONEncoding.default
        }


        var parameters = request.parameters ?? [:]
        parameters["access_token"] = userSession?.authorization.token

        return networker.request("https://api.github.com/" + request.path,
                                 method: request.method,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: request.headers)
            .responseJSON(completionHandler: { response in
                print(response.response ?? "")
                print(response.value ?? response.error?.localizedDescription ?? "Unknown error")

                // remove the github session if requesting with a session
                if let userSession = self.userSession,
                    let statusCode = response.response?.statusCode,
                    (statusCode == 401 || statusCode == 403) {
                    StatusBar.showRevokeError()
                    self.sessionManager.remove([userSession])
                } else {
                    request.completion(response)
                }
            })
    }
    
}
