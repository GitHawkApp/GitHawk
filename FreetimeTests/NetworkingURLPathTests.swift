//
//  NetworkingURLPathTests.swift
//  FreetimeTests
//
//  Created by B_Litwin on 5/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import GitHubAPI
import XCTest
@testable import Freetime

class UrlPathComponents: XCTestCase {
    
    func DISABLED_test_addReviewers() {
        
        //test that add reviewers request gets a 401 unauthorized response instead of a 404
        //Issue #1829: add reviewers was receiving a 404 response
        let addReviewersRequest = V3AddPeopleRequest(owner: "GitHawkApp",
                                                     repo: "GitHawk",
                                                     number: 1549,
                                                     type: .reviewers,
                                                     add: true,
                                                     people: [])
        
        let githubclient = GithubClient()
        let promise = expectation(description: "completion handler invoked")
        var requestResponse: GitHubAPI.Result<V3StatusCodeResponse<V3StatusCode200or201>>?
        
        githubclient.client.send(addReviewersRequest) { response in
            requestResponse = response
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        switch requestResponse! {
        case .failure(let error):
            let clientError = error as! GitHubAPI.ClientError
            switch clientError {
            case .unauthorized: break //test passed i.e. received a 401 response
            default: XCTFail("Client Error hould be .unauthorized i.e. 401 response")
            }
        default:
            XCTFail("Response should be ResponseType.failure(GitHubAPI.ClientError.unauthorized) i.e. 401 response")
        }
    }
    
    func DISABLED_test_addAssignees() {
        
        //test that add reviewers request gets a 401 unauthorized response
        let addAssigneesRequest = V3AddPeopleRequest(owner: "GitHawkApp",
                                                     repo: "GitHawk",
                                                     number: 1549,
                                                     type: .assignees,
                                                     add: true,
                                                     people: [])
        
        let githubclient = GithubClient()
        let promise = expectation(description: "completion handler invoked")
        var requestResponse: GitHubAPI.Result<V3StatusCodeResponse<V3StatusCode200or201>>?
        
        githubclient.client.send(addAssigneesRequest) { response in
            requestResponse = response
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        switch requestResponse! {
        case .failure(let error):
            let clientError = error as! GitHubAPI.ClientError
            switch clientError {
            case .unauthorized: break //test passed i.e. received a 401 response
            default: XCTFail("Client Error should be .unauthorized i.e. 401 response")
            }
        default:
            XCTFail("Response should be ResponseType.failure(GitHubAPI.ClientError.unauthorized) i.e. 401 response")
        }
    }
}

