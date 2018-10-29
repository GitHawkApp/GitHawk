//
//  MockClient.swift
//  FreetimeTests
//
//  Created by Hesham Salman on 10/29/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubAPI
import FlatCache
import Apollo

@testable import Freetime
extension GithubClient {
    init(mockClient: ClientType) {
        self.userSession = nil
        self.cache = FlatCache()
        self.bookmarksStore = nil
        self.client = mockClient
        self.badge = BadgeNotifications(client: mockClient)
    }
}

class MockCancellable: Cancellable {
    var didCancel = false
    func cancel() {
        didCancel = true
    }
}

class MockClient: ClientType {
    weak var delegate: ClientDelegate?

    private let httpPerformer: HTTPPerformer
    private let apollo: ApolloClient
    private let token: String?

    private var didSend = false

    init() {
        let config = ConfiguredNetworkers(
            token: nil,
            useOauth: nil
        )
        httpPerformer = config.alamofire
        apollo = config.apollo
        token = nil
    }

    func send<T>(_ request: T, completion: @escaping (Result<T.ResponseType>) -> Void) where T: HTTPRequest {
        didSend = true
    }

    func query<T, Q>(_ query: T, result: @escaping (T.Data) -> Q?, completion: @escaping (Result<Q>) -> Void) -> Cancellable where T : GraphQLQuery {
        return MockCancellable()
    }

    func mutate<T, Q>(_ mutation: T, result: @escaping (T.Data) -> Q?, completion: @escaping (Result<Q>) -> Void) -> Cancellable where T : GraphQLMutation {
        return MockCancellable()
    }

}
