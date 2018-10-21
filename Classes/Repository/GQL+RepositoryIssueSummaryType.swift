//
//  GQL+RepositoryIssueSummaryType.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

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

    var ciStatus: RepositoryIssueCIStatus? {
        return nil
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

    var ciStatus: RepositoryIssueCIStatus? {
        guard let node = commits.nodes?.first,
        let status = node?.commit.status
            else { return nil }
        return RepositoryIssueCIStatus(rawValue: status.state.rawValue)
    }

}
