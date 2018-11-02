//
//  GQL+RepositoryIssueSummaryType.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension RepoIssuePagesQuery.Data.Repository.Issue.Node: RepositoryIssueSummaryType {

    var labelableFields: LabelableFields {
        return fragments.labelableFields
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
        case .open, .__unknown: return .open
        }
    }

}

extension RepoPullRequestPagesQuery.Data.Repository.PullRequest.Node: RepositoryIssueSummaryType {

    var labelableFields: LabelableFields {
        return fragments.labelableFields
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
        case .merged: return .merged
        case .open, .__unknown: return .open
        }
    }

}

extension RepoSearchPagesQuery.Data.Search.Node.AsIssue: RepositoryIssueSummaryType {

    var labelableFields: LabelableFields {
        return fragments.labelableFields
    }

    var repoEventFields: RepoEventFields {
        return fragments.repoEventFields
    }

    var pullRequest: Bool {
        return false
    }

    var status: IssueStatus {
        switch issueState {
        case .closed: return .closed
        case .open, .__unknown: return .open
        }
    }

}

extension RepoSearchPagesQuery.Data.Search.Node.AsPullRequest: RepositoryIssueSummaryType {

    var labelableFields: LabelableFields {
        return fragments.labelableFields
    }

    var repoEventFields: RepoEventFields {
        return fragments.repoEventFields
    }

    var pullRequest: Bool {
        return true
    }

    var status: IssueStatus {
        switch pullRequestState {
        case .closed: return .closed
        case .merged: return .merged
        case .open, .__unknown: return .open
        }
    }

}
