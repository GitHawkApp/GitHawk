//
//  GithubClient+Repo.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

protocol RepositoryLoadable {
    var owner: String { get }
    var name: String { get }
}

extension RepositoryLoadable {
    var nameWithOwner: String {
        return owner + "/" + name
    }
}

extension GithubClient {
    
    enum RepoLoadResultType {
        case error
        case success(String?, [IssueSummaryType])
    }
    
    func load(repo: RepositoryLoadable, before: String? = nil, containerWidth: CGFloat, completion: @escaping (RepoLoadResultType) -> ()) {
        let query = RepoIssuesAndPullRequestsQuery(owner: repo.owner, name: repo.name, before: before)
        
        apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { (result, error) in
            guard error == nil, result?.errors == nil else {
                ShowErrorStatusBar(graphQLErrors: result?.errors, networkError: error)
                return
            }
            
            DispatchQueue.global().async {
                var builder = [IssueSummaryType]()
                
                result?.data?.repository?.issues.nodes?.forEach {
                    guard let issue = $0 else { return }
                    builder.append(IssueSummaryType(issue: issue, containerWidth: containerWidth))
                }
                
                DispatchQueue.main.async {
                    let nextPage: String? = {
                        guard let pageInfo = result?.data?.repository?.issues.pageInfo, pageInfo.hasNextPage else {
                            return nil
                        }
                        
                        return pageInfo.endCursor
                    }()
                    
                    completion(.success(nextPage, builder))
                }
            }
        }
    }
    
}
