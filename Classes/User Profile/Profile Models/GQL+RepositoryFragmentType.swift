//
//  GQL+RepositoryFragment.swift
//  Freetime
//
//  Created by B_Litwin on 8/12/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

extension UserStarredReposQuery.Data.User.StarredRepository.Node: RepositoryFragmentType {
    
    var ownerLogin: String {
        return owner.login
    }
    
    var starsCount: Int {
        return stargazers.totalCount
    }
    
    var primaryGitHubLanguage: GithubLanguage? {
        guard let language = primaryLanguage else { return nil }
        return GithubLanguage(name: language.name, color: language.color?.color)
    }
    
    var fragmentDefaultBranch: String {
        return defaultBranchRef?.name ?? "master"
    }
}


extension UserReposQuery.Data.User.Repository.Node: RepositoryFragmentType {
    
    var ownerLogin: String {
        return owner.login
    }
    
    var starsCount: Int {
        return stargazers.totalCount
    }
    
    var primaryGitHubLanguage: GithubLanguage? {
        guard let language = primaryLanguage else { return nil }
        return GithubLanguage(name: language.name, color: language.color?.color)
    }
    
    var fragmentDefaultBranch: String {
        return defaultBranchRef?.name ?? "master"
    }
    
}

extension UserQuery.Data.User.PinnedRepository.Node: RepositoryFragmentType {
    
    var ownerLogin: String {
        return owner.login
    }
    
    var starsCount: Int {
        return stargazers.totalCount
    }
    
    var primaryGitHubLanguage: GithubLanguage? {
        guard let language = primaryLanguage else { return nil }
        return GithubLanguage(name: language.name, color: language.color?.color)
    }
    
    var fragmentDefaultBranch: String {
        return defaultBranchRef?.name ?? "master"
    }
}







