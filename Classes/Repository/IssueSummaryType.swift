//
//  IssueSummaryType.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

protocol IssueSummaryType {

    var number: Int { get }
    var id: String { get }
    var status: IssueStatus { get }
    var repoEventFields: RepoEventFields { get }
    var pullRequest: Bool { get }
    var title: String { get }

}
