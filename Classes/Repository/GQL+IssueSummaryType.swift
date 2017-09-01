//
//  GQL+IssueSummaryType.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension RepoIssuesQuery.Data.Repository.Issue.Node: IssueSummaryType {
    var createdAtDate: Date? {
        return GithubAPIDateFormatter().date(from: createdAt)
    }
    
    var attributedTitle: NSAttributedStringSizing {
        let attributes = [
            NSFontAttributeName: Styles.Fonts.title,
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color
        ]
        
        return NSAttributedStringSizing(
            containerWidth: 0,
            attributedText: NSAttributedString(string: title, attributes: attributes),
            inset: RepositorySummaryCell.labelInset
        )
    }
    
    var rawState: String {
        return state.rawValue
    }
    
    var authorName: String? {
        return author?.login
    }
    
    var isIssue: Bool {
        return true
    }
}

extension RepoPullRequestsQuery.Data.Repository.PullRequest.Node: IssueSummaryType {
    var createdAtDate: Date? {
        return GithubAPIDateFormatter().date(from: createdAt)
    }

    var attributedTitle: NSAttributedStringSizing {
        let attributes = [
            NSFontAttributeName: Styles.Fonts.title,
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color
        ]
        
        return NSAttributedStringSizing(
            containerWidth: 0,
            attributedText: NSAttributedString(string: title, attributes: attributes),
            inset: RepositorySummaryCell.labelInset
        )
    }
    
    var rawState: String {
        return state.rawValue
    }
    
    var authorName: String? {
        return author?.login
    }
    
    var isIssue: Bool {
        return false
    }
}
