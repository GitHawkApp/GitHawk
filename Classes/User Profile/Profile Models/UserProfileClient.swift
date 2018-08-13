//
//  UserProfileClient.swift
//  Freetime
//
//  Created by B_Litwin on 8/12/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import Apollo

final class UserProfileClient {
    private let userLogin: String
    private let client: GithubClient
    
    init(client: GithubClient, userLogin: String) {
        self.userLogin = userLogin
        self.client = client
    }
    
    func fetchUserProfileInfo(completion: @escaping (GithubClient.UserProfileResultType) -> Void) {
        let query = UserQuery(login: userLogin)
        client.fetchUserProfile(query: query, completion: completion)
    }
    
    func fetchStarredRepositories(nextPage: String? = nil,
                                  completion: @escaping (GithubClient.RepositoryFragmentsResultType) -> Void)
    {
        let query = UserStarredReposQuery(login: userLogin, after: nextPage)
        client.fetchRepositories(query: query, completion: completion)
    }
    
    func fetchUserRepositories(nextPage: String? = nil,
                               completion: @escaping (GithubClient.RepositoryFragmentsResultType) -> Void) {
        let query = UserReposQuery(login: userLogin, after: nextPage)
        client.fetchRepositories(query: query, completion: completion)
    }
 }
