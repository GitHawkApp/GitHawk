//
//  IssuesViewController+UpdateTitle.swift
//  Freetime
//
//  Created by B_Litwin on 10/23/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension IssuesViewController {
    
    static func updateBookmarkTitle(
        newTitle: String,
        bookmark: Bookmark,
        bookmarkStore: BookmarkStore
        )
    {

        let newBookmark = Bookmark(
            type: bookmark.type,
            name: bookmark.name,
            owner: bookmark.owner,
            number: bookmark.number,
            title: newTitle,
            defaultBranch: bookmark.defaultBranch
        )
        
        if let index = bookmarkStore.values.index(of: bookmark) {
            bookmarkStore.values[index] = newBookmark
            bookmarkStore.save()
        }
    }
    
    static func updateIssueResultModelTitle(
        newTitle: String,
        oldTitle: String,
        username: String,
        issueResultModel: IssueResult,
        width: CGFloat
        ) -> IssueResult
    {
        
        let title = titleStringSizing(
            title: newTitle,
            contentSizeCategory: UIContentSizeCategory.preferred,
            width: width
        )
        
        let titleChangeString = IssueRenamedString(
            previous: oldTitle,
            current: newTitle,
            contentSizeCategory: UIContentSizeCategory.preferred,
            width: width
        )
        
        let issueRenamedModel = IssueRenamedModel(
            id: UUID().uuidString,
            actor: username,
            date: Date(),
            titleChangeString: titleChangeString
        )
        
        let issueResult = issueResultModel.updated(
            title: title,
            timelinePages: issueResultModel.timelinePages(appending: [issueRenamedModel])
        )
        
        return issueResult
    }
}
