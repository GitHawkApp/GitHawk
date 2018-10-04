//
//  SwitchBranches.swift
//  FreetimeTests
//
//  Created by B_Litwin on 10/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime

class SwitchBranches: XCTestCase {

    func test_branchesOrderAfterFetch() {
        let branches = [
            "master",
            "branch_1",
            "branch_2",
            "branch_3",
            "branch_4"
        ]
        
        var output = RepositoryBranchesViewController.arrangeBranches(
            selectedBranch: "master",
            defaultBranch: "master",
            branches: branches
        )
        
        XCTAssertEqual(output[0], "master")
        XCTAssertEqual(output[1], "branch_1")
        
        output = RepositoryBranchesViewController.arrangeBranches(
            selectedBranch: "branch_2",
            defaultBranch: "branch_3",
            branches: branches
        )
        
        XCTAssertEqual(output[0], "branch_2")
        XCTAssertEqual(output[1], "branch_3")
    }
    
}
