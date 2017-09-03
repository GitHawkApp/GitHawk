//
//  GQL+IssueSummaryType.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension RepoIssuePagesQuery.Data.Repository.Issue.Node: IssueSummaryType {

    var id: String {
        return fragments.nodeFields.id
    }

    var repoEventFields: RepoEventFields {
        return fragments.repoEventFields
    }

    var pullRequest: Bool {
        return false
    }

    var status: IssueStatus {
        switch state {
        case .closed: return .closed
        case .open: return .open
        }
    }

}

extension RepoPullRequestPagesQuery.Data.Repository.PullRequest.Node: IssueSummaryType {

    var id: String {
        return fragments.nodeFields.id
    }

    var repoEventFields: RepoEventFields {
        return fragments.repoEventFields
    }

    var pullRequest: Bool {
        return true
    }

    var status: IssueStatus {
        switch state {
        case .closed: return .closed
        case .open: return .open
        case .merged: return .merged
        }
    }
    
}

extension RepoDetailsQuery.Data.Repository.Issue.Node: IssueSummaryType {

    var id: String {
        return fragments.nodeFields.id
    }

    var repoEventFields: RepoEventFields {
        return fragments.repoEventFields
    }

    var pullRequest: Bool {
        return false
    }

    var status: IssueStatus {
        switch state {
        case .closed: return .closed
        case .open: return .open
        }
    }
    
}

extension RepoDetailsQuery.Data.Repository.PullRequest.Node: IssueSummaryType {

    var id: String {
        return fragments.nodeFields.id
    }

    var repoEventFields: RepoEventFields {
        return fragments.repoEventFields
    }

    var pullRequest: Bool {
        return true
    }

    var status: IssueStatus {
        switch state {
        case .closed: return .closed
        case .open: return .open
        case .merged: return .merged
        }
    }
    
}
