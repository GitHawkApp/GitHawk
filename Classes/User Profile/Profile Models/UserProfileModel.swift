//
//  UserModel.swift
//  Freetime
//
//  Created by B_Litwin on 8/12/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

class UserProfileModel {
    
    let avatarURL: String
    let bio: String?
    let bioHTML: String
    let company: String?
    let companyHTML: String
    let email: String
    let location: String?
    let login: String
    let name: String?
    let url: String
    let viewerCanFollow: Bool
    let viewIsFollowing: Bool
    
    let repositoriesCount: Int
    let starredReposCount: Int
    let pinnedRepositories: [RepositoryFragmentType]
    let followersCount: Int
    let followingCount: Int
    var followers: [UserSummaryModel]
    var following: [UserSummaryModel]
    
    init(user:  UserQuery.Data.User) {
        self.avatarURL = user.avatarUrl
        self.bio = user.bio
        self.bioHTML = user.bioHtml
        self.company = user.company
        self.companyHTML = user.companyHtml
        self.email = user.email
        self.location = user.location
        self.login = user.login
        self.name = user.name
        self.url = user.url
        self.viewerCanFollow = user.viewerCanFollow
        self.viewIsFollowing = user.viewerIsFollowing
        
        self.followingCount = user.following.totalCount
        self.followersCount = user.followers.totalCount
        self.following = user.following.userSummaries()
        self.followers = user.followers.userSummaries()
        self.pinnedRepositories = user.pinnedRepositories.nodes?.compactMap { $0 } ?? []
        self.repositoriesCount = user.repositories.totalCount
        self.starredReposCount = user.starredRepositories.totalCount
        
    }
}

class UserSummaryModel {
    let userLogin: String
    let avatarURL: String
    
    init(login: String, avatarURL: String) {
        self.userLogin = login
        self.avatarURL = avatarURL
    }
    
}

extension UserQuery.Data.User.Following {
    
    func userSummaries() -> [UserSummaryModel] {
        let following: [UserSummaryModel]
        if let nodes = nodes {
            let cleanNodes = nodes.compactMap { $0 }
            following = cleanNodes.map {
                UserSummaryModel(login: $0.login, avatarURL: $0.avatarUrl)
            }
        } else {
            following = []
        }
        return following
    }
    
}

extension UserQuery.Data.User.Follower {
    
    func userSummaries() -> [UserSummaryModel] {
        let followers: [UserSummaryModel]
        if let nodes = nodes {
            let cleanNodes = nodes.compactMap { $0 }
            followers = cleanNodes.map {
                UserSummaryModel(login: $0.login, avatarURL: $0.avatarUrl)
            }
        } else {
            followers = []
        }
        return followers
    }
    
}













