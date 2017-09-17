//
//  RepositoryEmptyResultsModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/3/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

enum RepositoryEmptyResultsType {

    case readme
    case issues
    case pullRequests

    var icon: UIImage? {
        switch self {
        case .readme: return UIImage(named: "file")
        case .issues: return UIImage(named: "issue-opened")
        case .pullRequests: return UIImage(named: "git-pull-request")
        }
    }

    var text: String {
        switch self {
        case .readme: return NSLocalizedString("Project has no README.", comment: "")
        case .issues: return NSLocalizedString("There aren't any issues.", comment: "")
        case .pullRequests: return NSLocalizedString("There aren't any pull requests.", comment: "")
        }
    }

}
