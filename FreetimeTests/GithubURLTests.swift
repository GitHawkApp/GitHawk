//
//  GithubURLTests.swift
//  FreetimeTests
//
//  Created by Viktoras Laukevicius on 20/02/2019.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime

class GithubURLTests: XCTestCase {

    func test_codeBlob() {
        let repo = RepositoryDetails(owner: "GitHawkApp", name: "GitHawk")
        let path = Freetime.FilePath(components: ["Classes", "Issues", "AddCommentClient.swift"])
        let url = GithubURL.codeBlob(repo: repo, branch: "master", path: path)!
        XCTAssertEqual(url.absoluteString, "https://github.com/GitHawkApp/GitHawk/blob/master/Classes/Issues/AddCommentClient.swift")
    }
}
