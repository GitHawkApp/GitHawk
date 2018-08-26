//
//  GitHubAPITests.swift
//  GitHubAPITests
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import GitHubAPI
import Apollo

struct TestResponse: EntityResponse {
    typealias InputType = [String: Any]
    typealias OutputType = String

    let data: String

    init(input: [String: Any], response: HTTPURLResponse?) throws {
        guard let data = input["Test"] as? String else {
            throw ResponseError.parsing("Missing Test key")
        }
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
        let result = processResponse(request: TestRequest(), input: 42)
        switch result {
        case .success: XCTFail()
        case .failure: break
        }
    }

    func test_processResponse_whenOutputNil() {
        let result = processResponse(request: TestRequest(), input: ["foo":"bar"])
        switch result {
        case .failure(let error):
            switch error as! ClientError {
            case .mismatchedInput, .network, .unauthorized: XCTFail()
            case .outputNil: break
            }
        case .success: XCTFail()
        }
    }

    func test_processResponse_whenOutputExists() {
        let result = processResponse(request: TestRequest(), input: ["Test":"foo"])
        switch result {
        case .failure: XCTFail()
        case .success(let response): XCTAssertEqual(response.data, "foo")
        }
    }

    func test_processResponse_whenNetworkError() {
        let result = processResponse(request: TestRequest(), input: ["Test":"bar"], error: NSError(domain: "networking", code: 500, userInfo: nil))
        switch result {
        case .failure(let error):
            switch error as! ClientError {
            case .network: break
            case .mismatchedInput, .outputNil, .unauthorized: XCTFail()
            }
        case .success: XCTFail()
        }
    }

    func test_notificationsJSON() {
        let data = try! Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "notifications", withExtension: "json")!)
        let result = processResponse(request: V3NotificationRequest(), input: data)
        switch result {
        case .failure: XCTFail()
        case .success(let response):
            XCTAssertEqual(response.data.count, 50)

            let first = response.data.first!
            XCTAssertEqual(first.id, "309092405")
            XCTAssertEqual(first.reason, .subscribed)
            XCTAssertEqual(first.repository.name, "GitHawk")
            XCTAssertEqual(first.repository.owner.login, "rnystrom")
            XCTAssertEqual(first.subject.title, "Add merge status tests")
        }
    }

    func test_sendingNotifications() {
        let data = try! Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "notifications", withExtension: "json")!)
        let performer = TestHTTPPerformer(mockResponse: data, mockError: nil)
        let client = Client(httpPerformer: performer, apollo: ApolloClient(url: URL(string: "http://google.com")!))

        let expectation = XCTestExpectation()
        client.send(V3NotificationRequest()) { (result) in
            switch result {
            case .success(let response): XCTAssertEqual(response.data.count, 50)
            case .failure: XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 15)
    }

    func test_invitationJSON() {
        let data = try! Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "invitation_notification", withExtension: "json")!)
        let result = processResponse(request: V3NotificationRequest(), input: data)
        switch result {
        case .failure(let error): XCTFail(error?.localizedDescription ?? "Failed without error")
        case .success(let response):
            XCTAssertEqual(response.data.count, 1)

            let first = response.data.first!
            XCTAssertEqual(first.id, "317864347")
            XCTAssertEqual(first.reason, .subscribed)
            XCTAssertEqual(first.repository.name, "Attributed")
            XCTAssertEqual(first.repository.owner.login, "Nirma")
            let repo = "\(first.repository.owner.login)/\(first.repository.name)"
            XCTAssertEqual(first.subject.title, "Invitation to join \(repo) from \(first.repository.owner.login)")
        }
    }

    func test_securityVulnerabilityJSON() {
        let data = try! Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "security_vulnerability", withExtension: "json")!)
        let result = processResponse(request: V3NotificationRequest(), input: data)
        switch result {
        case .failure(let error): XCTFail(error?.localizedDescription ?? "Failed without error")
        case .success(let response):
            XCTAssertEqual(response.data.count, 1)

            let first = response.data.first!
            XCTAssertEqual(first.id, "328706116")
            XCTAssertEqual(first.reason, .securityAlert)
            XCTAssertEqual(first.repository.name, "eslint-docs")
            XCTAssertEqual(first.repository.owner.login, "j-f1")
            XCTAssertEqual(first.subject.title, "Potential security vulnerability found in the hoek dependency")
        }
    }

    func test_milestoneWithoutDescriptionsJSON() {
        let data = try! Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "no_milestone_description", withExtension: "json")!)
        let result = processResponse(request: V3MilestoneRequest(owner: "nurpax", repo: "petmate"), input: data)
        switch result {
        case .failure(let error): XCTFail(error?.localizedDescription ?? "Failed without error")
        case .success(let response):
            XCTAssertEqual(response.data.count, 2)

            let first = response.data.first!
            XCTAssertEqual(first.id, 3514116)
            XCTAssertEqual(first.closedIssues, 6)
            XCTAssertEqual(first.openIssues, 6)
            XCTAssertNil(first.description)
            XCTAssertNil(first.closedAt)
        }
    }
    
}
