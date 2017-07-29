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
    
    struct RepositoryLoadSuccessPayload {
        let issues: [IssueSummaryModel]?
        let issuesNextPage: String?
        let pullRequests: [IssueSummaryModel]?
        let pullRequestsNextPage: String?
    }
    
    enum RepoLoadResultType {
        case error
        case success(RepositoryLoadSuccessPayload)
    }
    
    func load(repo: RepositoryLoadable,
              before: String? = nil,
              includeIssues: Bool = true,
              includePullRequests: Bool = true,
              containerWidth: CGFloat,
              completion: @escaping (RepoLoadResultType) -> ()) {
        
        let query = RepoIssuesAndPullRequestsQuery(
            owner: repo.owner,
            name: repo.name,
            before: before,
            includeIssues: includeIssues,
            includePullRequests: includePullRequests
        )
        
        apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { (result, error) in
            guard error == nil, result?.errors == nil else {
                ShowErrorStatusBar(graphQLErrors: result?.errors, networkError: error)
                return
            }
            
            DispatchQueue.global().async {
                let issues: [IssueSummaryModel]? = result?.data?.repository?.issues?.nodes?.flatMap {
                    guard let issue = $0 else { return nil }
                    issue.attributedTitle.computeSize(containerWidth)
                    return IssueSummaryModel(info: issue)
                }
                
                let pullRequests: [IssueSummaryModel]? = result?.data?.repository?.pullRequests?.nodes?.flatMap {
                    guard let pr = $0 else { return nil }
                    pr.attributedTitle.computeSize(containerWidth)
                    return IssueSummaryModel(info: pr)
                }
                
                let issuesNextPage: String? = {
                    guard let pageInfo = result?.data?.repository?.issues?.pageInfo, pageInfo.hasNextPage else {
                        return nil
                    }
                    
                    return pageInfo.endCursor
                }()
                
                let pullRequestNextPage: String? = {
                    guard let pageInfo = result?.data?.repository?.pullRequests?.pageInfo, pageInfo.hasNextPage else {
                        return nil
                    }
                    
                    return pageInfo.endCursor
                }()
                
                let payload = RepositoryLoadSuccessPayload(issues: issues, issuesNextPage: issuesNextPage,
                                                           pullRequests: pullRequests, pullRequestsNextPage: pullRequestNextPage)
                
                DispatchQueue.main.async {
                    completion(.success(payload))
                }
            }
        }
    }
    
}
