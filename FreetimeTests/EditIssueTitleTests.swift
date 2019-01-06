//
//  EditIssueTitleTests.swift
//  FreetimeTests
//
//  Created by B_Litwin on 1/6/19.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime

class EditIssueTitleTests: XCTestCase {

    func test_editIssueTitleViewController() {
        let editIssueTitleViewController = EditIssueTitleViewController(
            issueTitle: "text"
        )
        
        editIssueTitleViewController.viewDidLoad()
        
        let textView = editIssueTitleViewController.view.subviews.first(where: {
            $0 is UITextView
        }) as! UITextView
        
        /*
            The editIssueTitle flag in EditIssueTitleViewController
            is used to communicate to the IssueManagingContextController
            whether to send a network request to update the issue title.
            Null should signal that a request is not necessary,
            and a text value should signal that an update request is neccessary.
         
            onSave() or onCancel() will dismiss the ViewController, so only need
            to test the editIssueTitle flag once, directly after one of those is called
         
            The following tests verify that the only time the flag is set to send a
            network request is under the conditions that a new title has been entered
            and onSave() is called
         */
        
        XCTAssertNil(editIssueTitleViewController.editedIssueTitle)
        
        editIssueTitleViewController.onSave()
        XCTAssertNil(editIssueTitleViewController.editedIssueTitle)
        
        textView.text = "new text"
        
        editIssueTitleViewController.onCancel()
        XCTAssertNil(editIssueTitleViewController.editedIssueTitle)
        
        editIssueTitleViewController.onSave()
        XCTAssert(editIssueTitleViewController.editedIssueTitle == "new text")
    }

}
