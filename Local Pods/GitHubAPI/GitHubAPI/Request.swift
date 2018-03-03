//
//  Parser.swift
//  Freetime
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import Apollo

public protocol Response {
    associatedtype InputType
    associatedtype OutputType
    init?(input: InputType)
}

public protocol EntityResponse: Response {
    var data: OutputType { get }
}

public protocol CollectionResponse: Response {
    var data: [OutputType] { get }
}

public protocol Request {
    associatedtype ResponseType: Response
}

public enum HTTPMethod {
    case get
    case post
    case put
    case patch
    case delete
}

public protocol HTTPRequest: Request {
    var url: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var logoutOnAuthFailure: Bool { get }
}

public protocol GitHubGraphQLQueryRequest: Request {
    associatedtype QueryType: GraphQLQuery
    var query: QueryType { get }
}

public protocol GitHubGraphQLMutationRequest: Request {
    associatedtype MutationType: GraphQLMutation
    var mutation: MutationType { get }
}

public enum Result<Response> {
    case success(Response)
    case failure(ClientError?)
}

public enum ClientError: Error {
    case unauthorized
    case mismatchedInput
    case outputNil
    case network(Error?)
}

protocol HTTPPerformer {
    func send(
        url: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: [String: String]?,
        completion: @escaping (HTTPURLResponse?, Any?, Error?) -> Void
    )
}

internal func processResponse<T: Request>(request: T, input: Any?, error: Error?) -> Result<T.ResponseType> {
    guard let input = input as? T.ResponseType.InputType else {
        return .failure(ClientError.mismatchedInput)
    }
    guard error == nil else {
        return .failure(ClientError.network(error))
    }
    guard let output = T.ResponseType(input: input) else {
        return .failure(ClientError.outputNil)
    }
    return .success(output)
}

public class Client {

    private let httpPerformer: HTTPPerformer
    private let apollo: ApolloClient

    init(
        httpPerformer: HTTPPerformer,
        apollo: ApolloClient
        ) {
        self.httpPerformer = httpPerformer
        self.apollo = apollo
    }

    public func send<T: HTTPRequest>(_ request: T, completion: @escaping (Result<T.ResponseType>) -> Void) {
        httpPerformer.send(
            url: request.url,
            method: request.method,
            parameters: request.parameters,
            headers: request.headers) { (response, json, error) in
                if request.logoutOnAuthFailure,
                    let statusCode = response?.statusCode,
                    statusCode == 401 {
                    completion(.failure(ClientError.unauthorized))
                } else {
                    completion(processResponse(request: request, input: json, error: error))
                }
        }
    }

    public func query<T: GitHubGraphQLQueryRequest>(_ request: T, completion: @escaping (Result<T.ResponseType>) -> Void) {
        apollo.fetch(query: request.query, cachePolicy: .fetchIgnoringCacheData) { (response, error) in
            completion(processResponse(request: request, input: response, error: error))
        }
    }

    public func mutate<T: GitHubGraphQLMutationRequest>(_ request: T, completion: @escaping (Result<T.ResponseType>) -> Void) {
        apollo.perform(mutation: request.mutation) { (response, error) in
            completion(processResponse(request: request, input: response, error: error))
        }
    }

}

