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

    struct Page {
        let next: Int
        let last: Int
    }

    struct Request {

        let url: String
        let method: HTTPMethod
        let parameters: Parameters?
        let headers: HTTPHeaders?
        let completion: (DataResponse<Any>, Page?) -> Void

        init(
            path: String,
            method: HTTPMethod = .get,
            parameters: Parameters? = nil,
            headers: HTTPHeaders? = nil,
            completion: @escaping (DataResponse<Any>, Page?) -> Void
            ) {
            self.init(
                url: "https://api.github.com/" + path,
                method: method,
                parameters: parameters,
                headers: headers,
                completion: completion
            )
        }

        init(
            url: String,
            method: HTTPMethod = .get,
            parameters: Parameters? = nil,
            headers: HTTPHeaders? = nil,
            completion: @escaping (DataResponse<Any>, Page?) -> Void
            ) {
            self.url = url
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
        print("Requesting \(request.method.rawValue): \(request.url)")

        let encoding: ParameterEncoding
        switch request.method {
        case .get: encoding = URLEncoding.queryString
        default: encoding = JSONEncoding.default
        }

        var parameters = request.parameters ?? [:]
        parameters["access_token"] = userSession?.token

        return networker.request(request.url,
                                 method: request.method,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: request.headers)
            .responseJSON(completionHandler: { response in
                // remove the github session if requesting with a session
                if let statusCode = response.response?.statusCode,
                    (statusCode == 401 || statusCode == 403) {
                    StatusBar.showRevokeError()
                    self.sessionManager.logout()
                } else {
                    let page = PagingData(link: response.response?.allHeaderFields["Link"] as? String)
                    request.completion(response, page)
                }
            })
    }
    
}
