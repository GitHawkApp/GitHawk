//
//  GithubClient.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/16/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import Alamofire
import Apollo
import AlamofireNetworkActivityIndicator
import FlatCache

struct GithubClient {

    struct Page {
        let next: Int
        let last: Int
    }

    struct Request {

        enum RequestType {
            case api, site, status
        }

        let path: String
        let type: RequestType
        let method: HTTPMethod
        let parameters: Parameters?
        let headers: HTTPHeaders?
        let logoutOnAuthFailure: Bool
        let completion: (DataResponse<Any>, Page?) -> Void

        static func api(
            path: String,
            method: HTTPMethod = .get,
            parameters: Parameters? = nil,
            headers: HTTPHeaders? = nil,
            logoutOnAuthFailure: Bool = true,
            completion: @escaping (DataResponse<Any>, Page?) -> Void
            ) -> Request {
            return Request(
                type: .api,
                path: path,
                method: method,
                parameters: parameters,
                headers: headers,
                logoutOnAuthFailure: logoutOnAuthFailure,
                completion: completion
            )
        }

        static func site(
            path: String,
            method: HTTPMethod = .get,
            parameters: Parameters? = nil,
            headers: HTTPHeaders? = nil,
            logoutOnAuthFailure: Bool = true,
            completion: @escaping (DataResponse<Any>, Page?) -> Void
            ) -> Request {
            return Request(
                type: .site,
                path: path,
                method: method,
                parameters: parameters,
                headers: headers,
                logoutOnAuthFailure: logoutOnAuthFailure,
                completion: completion
            )
        }

        static func status(
            method: HTTPMethod = .get,
            parameters: Parameters? = nil,
            headers: HTTPHeaders? = nil,
            logoutOnAuthFailure: Bool = true,
            completion: @escaping (DataResponse<Any>, Page?) -> Void
            ) -> Request {
            return Request(
                type: .status,
                path: "status.json",
                method: method,
                parameters: parameters,
                headers: headers,
                logoutOnAuthFailure: logoutOnAuthFailure,
                completion: completion
            )
        }

        private init(
            type: RequestType,
            path: String,
            method: HTTPMethod = .get,
            parameters: Parameters? = nil,
            headers: HTTPHeaders? = nil,
            logoutOnAuthFailure: Bool = true,
            completion: @escaping (DataResponse<Any>, Page?) -> Void
            ) {
            self.type = type
            self.path = path
            self.method = method
            self.parameters = parameters
            self.headers = headers
            self.logoutOnAuthFailure = logoutOnAuthFailure
            self.completion = completion
        }
    }

    let sessionManager: GithubSessionManager
    let apollo: ApolloClient
    let networker: Alamofire.SessionManager
    let userSession: GithubUserSession?
    let cache = FlatCache()
    let bookmarksStore: BookmarkStore?

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

        if let token = userSession?.token {
            self.bookmarksStore = BookmarkStore(token: token)
        } else {
            self.bookmarksStore = nil
        }
    }

    @discardableResult
    func request(
        _ request: GithubClient.Request
        ) -> DataRequest {
        let url = constructURL(from: request)
        print("Requesting \(request.method.rawValue): \(url)")

        let encoding: ParameterEncoding
        switch request.method {
        case .get: encoding = URLEncoding.queryString
        default: encoding = JSONEncoding.default
        }

        var parameters = request.parameters ?? [:]
        parameters["access_token"] = userSession?.token

        return networker.request(url,
                                 method: request.method,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: request.headers)
            .responseJSON(completionHandler: { response in
                // remove the github session if requesting with a session
                if request.logoutOnAuthFailure,
                    let statusCode = response.response?.statusCode,
                    statusCode == 401 {
                    ToastManager.showRevokeError()
                    self.sessionManager.logout()
                } else {
                    let page = PagingData(link: response.response?.allHeaderFields["Link"] as? String)
                    request.completion(response, page)
                }
            })
    }

    @discardableResult
    func graphQL(
        parameters: Parameters,
        completion: @escaping (DataResponse<Any>) -> Void
        ) -> DataRequest {
        let encoding: ParameterEncoding = JSONEncoding.default
        return networker.request(
            graphQLEndpoint,
            method: .post,
            parameters: parameters,
            encoding: encoding,
            headers: ["Authorization": "bearer " + (userSession?.token ?? "")]
            )
            .responseJSON(completionHandler: { response in
                completion(response)
            })
    }

    @discardableResult
    func fetch<Query: GraphQLQuery>(
        query: Query,
        resultHandler: OperationResultHandler<Query>? = nil
        ) -> Cancellable {
        NetworkActivityIndicatorManager.shared.incrementActivityCount()
        return apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheData, resultHandler: { (result, error) in
            NetworkActivityIndicatorManager.shared.decrementActivityCount()
            resultHandler?(result, error)
        })
    }

    @discardableResult
    func perform<Mutation: GraphQLMutation>(
        mutation: Mutation,
        resultHandler: OperationResultHandler<Mutation>?
        ) -> Cancellable {
        NetworkActivityIndicatorManager.shared.incrementActivityCount()
        return apollo.perform(mutation: mutation, resultHandler: { (result, error) in
            NetworkActivityIndicatorManager.shared.decrementActivityCount()
            resultHandler?(result, error)
        })
    }

    static func url(baseURL: String = "https://github.com/", path: String) -> URL? {
        return URL(string: "\(baseURL)\(path)")
    }

    // MARK: Private
    private func constructURL(from request: Request) -> String {
        let baseURL: String
        if let enterpriseURL = userSession?.enterpriseURL {
            switch request.type {
            case .api:
                baseURL = "\(enterpriseURL)api/v3"
            case .site:
                baseURL = enterpriseURL
            case .status:
                assert(false, "Status checking is unsupported in GitHub Enterprise")
                baseURL = "invalid-url"
            }
        } else {
            switch request.type {
            case .api:
                baseURL = "https://api.github.com/"
            case .site:
                baseURL = "https://github.com/"
            case .status:
                baseURL = "https://status.github.com/api/"
            }
        }

        return "\(baseURL)\(request.path)"
    }

    private var graphQLEndpoint: String {
        if let enterpriseURL = userSession?.enterpriseURL {
            return "\(enterpriseURL)/api/graphql"
        } else {
            return "https://api.github.com/graphql"
        }
    }

}
