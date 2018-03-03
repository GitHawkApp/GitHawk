//
//  GitHubAPITests.swift
//  GitHubAPITests
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import GitHubAPI

struct TestResponse: EntityResponse {
    typealias InputType = [String: Any]
    typealias OutputType = String

    let data: String

    init?(input: [String: Any]) {
        guard let data = input["Test"] as? String else { return nil }
        self.data = data
    }
}

struct TestRequest: HTTPRequest {
    typealias ResponseType = TestResponse

    let url: String = "http://githawk.com"
    let method: HTTPMethod = .get
    let parameters: [String: Any]? = nil
    let headers: [String: String]? = nil
    let logoutOnAuthFailure: Bool = false
}

struct TestHTTPPerformer: HTTPPerformer {

    let mockResponse: Any?
    let mockError: Error?

    func send(url: String, method: HTTPMethod, parameters: [String : Any]?, headers: [String : String]?, completion: @escaping (HTTPURLResponse?, Any?, Error?) -> Void) {
        let response = HTTPURLResponse(url: URL(string: url)!, mimeType: nil, expectedContentLength: 42, textEncodingName: nil)
        completion(response, mockResponse, mockError)
    }

}

class GitHubAPITests: XCTestCase {
    
    func test_processResponse_whenWrongInput() {
        let result = processResponse(request: TestRequest(), input: 42, error: nil)
        switch result {
        case .success: XCTFail()
        case .failure: break
        }
    }

    func test_processResponse_whenOutputNil() {
        let result = processResponse(request: TestRequest(), input: ["foo":"bar"], error: nil)
        switch result {
        case .failure(let error):
            switch error! {
            case .mismatchedInput, .network, .unauthorized: XCTFail()
            case .outputNil: break
            }
        case .success: XCTFail()
        }
    }

    func test_processResponse_whenOutputExists() {
        let result = processResponse(request: TestRequest(), input: ["Test":"foo"], error: nil)
        switch result {
        case .failure: XCTFail()
        case .success(let response): XCTAssertEqual(response.data, "foo")
        }
    }
    
}
