//
//  Client.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import Apollo

public protocol HTTPPerformer {
    func send(
        url: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: [String: String]?,
        completion: @escaping (HTTPURLResponse?, Any?, Error?) -> Void
    )
}

public protocol ClientDelegate: class {
    func didUnauthorize(client: Client)
}

public class Client {

    weak var delegate: ClientDelegate?

    private let httpPerformer: HTTPPerformer
    private let apollo: ApolloClient?
    private let token: String?

    public init(
        httpPerformer: HTTPPerformer,
        apollo: ApolloClient? = nil,
        token: String? = nil
        ) {
        self.httpPerformer = httpPerformer
        self.apollo = apollo
        self.token = token
    }

    public func send<T: HTTPRequest>(_ request: T, completion: @escaping (Result<T.ResponseType>) -> Void) {
        var parameters = request.parameters ?? [:]
        parameters["access_token"] = token

        httpPerformer.send(
            url: request.url,
            method: request.method,
            parameters: parameters,
            headers: request.headers) { [weak self] (response, json, error) in
                guard let strongSelf = self else { return }

                if request.logoutOnAuthFailure,
                    let statusCode = response?.statusCode,
                    statusCode == 401 {
                    completion(.failure(ClientError.unauthorized))
                    strongSelf.delegate?.didUnauthorize(client: strongSelf)
                } else {
                    asyncProcessResponse(request: request, input: json, response: response, error: error, completion: completion)
                }
        }
    }

    public func query<T: GitHubGraphQLQueryRequest>(
        _ request: T,
        completion: @escaping (Result<T.ResponseType>) -> Void
        ) {
        apollo?.fetch(query: request.query, cachePolicy: .fetchIgnoringCacheData) { (response, error) in
            asyncProcessResponse(
                request: request,
                input: response,
                response: nil,
                error: error,
                completion: completion
            )
        }
    }

    public func mutate<T: GitHubGraphQLMutationRequest>(
        _ request: T,
        completion: @escaping (Result<T.ResponseType>) -> Void
        ) {
        apollo?.perform(mutation: request.mutation) { (response, error) in
            asyncProcessResponse(
                request: request,
                input: response,
                response: nil,
                error: error,
                completion: completion
            )
        }
    }

}
