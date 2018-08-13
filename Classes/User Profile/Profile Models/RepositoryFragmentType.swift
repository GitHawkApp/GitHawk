//
//  RepositoryFragmentType.swift
//  Freetime
//
//  Created by B_Litwin on 8/12/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

protocol RepositoryFragmentType {
    
    var id: String { get }
    var ownerLogin: String { get }
    var name: String { get }
    var description: String? { get }
    var starsCount: Int { get }
    var hasIssuesEnabled: Bool { get }
    var primaryGitHubLanguage: GithubLanguage? { get }
    var fragmentDefaultBranch: String { get }
    
}

