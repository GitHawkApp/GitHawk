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

        let url: String
        let method: HTTPMethod
        let parameters: Parameters?
        let headers: HTTPHeaders?
        let logoutOnAuthFailure: Bool
        let completion: (DataResponse<Any>, Page?) -> Void

        init(
            client: Client?,
            path: String,
            method: HTTPMethod = .get,
            parameters: Parameters? = nil,
            headers: HTTPHeaders? = nil,
            logoutOnAuthFailure: Bool = true,
            completion: @escaping (DataResponse<Any>, Page?) -> Void
            ) {
            
            guard let url = client?.apiUrl(path: path) else {
                fatalError("Attempted to make request without a client!")
            }
            
            self.init(
                url: url,
                method: method,
                parameters: parameters,
                headers: headers,
                logoutOnAuthFailure: logoutOnAuthFailure,
                completion: completion
            )
        }

        init(
            url: String,
            method: HTTPMethod = .get,
            parameters: Parameters? = nil,
            headers: HTTPHeaders? = nil,
            logoutOnAuthFailure: Bool = true,
            completion: @escaping (DataResponse<Any>, Page?) -> Void
            ) {
            self.url = url
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

}
