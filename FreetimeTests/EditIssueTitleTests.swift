//
//  EditIssueTitleTest.swift
//  FreetimeTests
//
//  Created by B_Litwin on 10/22/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
import GitHubAPI
import FlatCache
@testable import Freetime

class EditIssueTitleTests: XCTestCase {

    var issueResult: IssueResult!
    var bookmark: Bookmark!
    var bookmarkStore: BookmarkStore!
    
    override func setUp() {
        let issueTitle = "Testing"
        
        let titleString = titleStringSizing(
            title: issueTitle,
            contentSizeCategory: UIContentSizeCategory.preferred,
            width: 1
        )
        
        let issueLabelModel = IssueLabelsModel(
            status: IssueLabelStatusModel(status: .open, pullRequest: false),
            locked: false,
            labels: []
        )
        
        issueResult = IssueResult(
            id: "",
            pullRequest: false,
            title: titleString,
            labels: issueLabelModel,
            assignee: IssueAssigneesModel(users: [], type: .assigned),
            rootComment: nil,
            reviewers: nil,
            milestone: nil,
            targetBranch: nil,
            timelinePages: [],
            viewerCanUpdate: false,
            hasIssuesEnabled: false,
            viewerCanAdminister: false,
            defaultBranch: "",
            fileChanges: nil,
            mergeModel: nil
        )
        
        bookmark = Bookmark(type: .issue, name: "Bookmark Test", owner: "brianlitwin", title: issueTitle)
        bookmarkStore = BookmarkStore(token: "")
        bookmarkStore.values = [bookmark]
    }

    func test_editTitle_updatesBookmarkStore() {
        XCTAssertEqual(bookmarkStore.values[0].title, "Testing")
        
        IssuesViewController.updateBookmarkTitle(
            newTitle: "Check 1",
            bookmark: bookmarkStore.values[0],
            bookmarkStore: bookmarkStore
        )
        XCTAssertEqual(bookmarkStore.values[0].title, "Check 1")
        
        IssuesViewController.updateBookmarkTitle(
            newTitle: "Check 2",
            bookmark: bookmarkStore.values[0],
            bookmarkStore: bookmarkStore
        )
        XCTAssertEqual(bookmarkStore.values[0].title, "Check 2")
    }
    
    func test_editTitle_updateIssueResultModel() {
        
        // Initital conditions
        XCTAssertEqual(issueResult.title.string.allText, "Testing")
        XCTAssertEqual(issueResult.timelinePages.count, 0)
        
        let newIssueResult = IssuesViewController.updateIssueResultModelTitle(
            newTitle: "Check 1",
            oldTitle: issueResult.title.string.allText,
            username: "user",
            issueResultModel: issueResult,
            width: 200
        )
        XCTAssertEqual(newIssueResult.title.string.allText, "Check 1")
        
        //Test that a new model is added to the timeline
        let issueRenamedModel = newIssueResult.timelinePages[0].viewModels[0] as! IssueRenamedModel
        XCTAssertEqual(issueRenamedModel.titleChangeString.string.allText, "Testing to Check 1")
    }
}
