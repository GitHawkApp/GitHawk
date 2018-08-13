//
//  UserProfileClient.swift
//  Freetime
//
//  Created by B_Litwin on 8/12/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import Apollo


protocol UserProfileReposQuery {
    func repositoryFragments(from data: GraphQLSelectionSet) -> [RepositoryFragmentType]
    func nextPageToken(from data: GraphQLSelectionSet) -> String?
}

extension UserStarredReposQuery: UserProfileReposQuery {
    
    func repositoryFragments(from data: GraphQLSelectionSet) -> [RepositoryFragmentType] {
        guard let queryData = data as? Data else { return [] }
        return queryData.user?.starredRepositories.nodes?.compactMap { $0 } ?? []
    }
    
    func nextPageToken(from data: GraphQLSelectionSet) -> String? {
        guard let queryData = data as? Data else { return nil }
        guard let pageInfo = queryData.user?.starredRepositories.pageInfo, pageInfo.hasNextPage else { return nil }
        return pageInfo.endCursor
    }

}

extension UserReposQuery: UserProfileReposQuery {
    
    func repositoryFragments(from data: GraphQLSelectionSet) -> [RepositoryFragmentType] {
        guard let queryData = data as? Data else { return [] }
        return queryData.user?.repositories.nodes?.compactMap { $0 } ?? []
    }
    
    func nextPageToken(from data: GraphQLSelectionSet) -> String? {
        guard let queryData = data as? Data else { return nil }
        guard let pageInfo = queryData.user?.repositories.pageInfo, pageInfo.hasNextPage else { return nil }
        return pageInfo.endCursor
    }
    
}













