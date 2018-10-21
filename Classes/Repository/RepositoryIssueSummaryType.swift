//
//  RepositoryIssueSummaryType.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

enum RepositoryIssueCIStatus: String {
    case pending = "PENDING"
    case failure = "FAILURE"
    case success = "SUCCESS"
}

protocol RepositoryIssueSummaryType {

    var number: Int { get }
    var id: String { get }
    var status: IssueStatus { get }
    var repoEventFields: RepoEventFields { get }
    var labelableFields: LabelableFields { get }
    var pullRequest: Bool { get }
    var title: String { get }
    var ciStatus: RepositoryIssueCIStatus? { get }

}
