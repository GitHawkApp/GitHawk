//
//  RepositoryClient.swift
//  Freetime
//
//  Created by Sherlock, James on 30/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Apollo

protocol RepositoryLoadable {
    var owner: String { get }
    var name: String { get }
    var hasIssuesEnabled: Bool { get }
}

extension RepositoryLoadable {
    var nameWithOwner: String {
        return owner + "/" + name
    }
}

protocol RepositoryQuery {
    init(owner: String, name: String, after: String?)
    func summaryTypes(from data: GraphQLMappable) -> [IssueSummaryType]
    func nextPageToken(from data: GraphQLMappable) -> String?
}

extension RepoIssuesQuery: RepositoryQuery {
    func summaryTypes(from data: GraphQLMappable) -> [IssueSummaryType] {
        guard let issues = data as? RepoIssuesQuery.Data else { return [] }
        return issues.repository?.issues.nodes?.flatMap { $0 } ?? []
    }
    
    func nextPageToken(from data: GraphQLMappable) -> String? {
        guard let issues = data as? RepoIssuesQuery.Data else { return nil }
        guard let pageInfo = issues.repository?.issues.pageInfo, pageInfo.hasNextPage else { return nil }
        return pageInfo.endCursor
    }
}

extension RepoPullRequestsQuery: RepositoryQuery {
    func summaryTypes(from data: GraphQLMappable) -> [IssueSummaryType] {
        guard let prs = data as? RepoPullRequestsQuery.Data else { return [] }
        return prs.repository?.pullRequests.nodes?.flatMap { $0 } ?? []
    }
    
    func nextPageToken(from data: GraphQLMappable) -> String? {
        guard let prs = data as? RepoPullRequestsQuery.Data else { return nil }
        guard let pageInfo = prs.repository?.pullRequests.pageInfo, pageInfo.hasNextPage else { return nil }
        return pageInfo.endCursor
    }
}

final class RepositoryClient {

    var issues = [IssueSummaryModel]()
    var issuesNextPage: String?
    
    var pullRequests = [IssueSummaryModel]()
    var pullRequestsNextPage: String?
    
    let githubClient: GithubClient
    let repo: RepositoryLoadable
    
    init(githubClient: GithubClient, repo: RepositoryLoadable) {
        self.githubClient = githubClient
        self.repo = repo
    }
    
    struct RepositoryLoadSuccessPayload {
        let models: [IssueSummaryModel]?
        let nextPage: String?
    }
    
    enum RepoLoadResultType {
        case error
        case success(RepositoryLoadSuccessPayload)
    }
    
    private func load<T: GraphQLQuery>(queryType: T.Type,
                                       repo: RepositoryLoadable,
                                       after: String? = nil,
                                       containerWidth: CGFloat,
                                       completion: @escaping (RepoLoadResultType) -> ()) where T: RepositoryQuery {
        let query = queryType.init(owner: repo.owner, name: repo.name, after: after)
        
        githubClient.apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { (result, error) in
            guard error == nil, result?.errors == nil, let data = result?.data else {
                ShowErrorStatusBar(graphQLErrors: result?.errors, networkError: error)
                completion(.error)
                return
            }
            
            let summaries: [IssueSummaryModel] = query.summaryTypes(from: data).map { summaryType in
                summaryType.attributedTitle.computeSize(containerWidth)
                return IssueSummaryModel(info: summaryType)
            }
            
            completion(.success(RepositoryLoadSuccessPayload(models: summaries, nextPage: query.nextPageToken(from: data))))
        }
    }
    
    func loadMoreIssues(containerWidth: CGFloat, completion: @escaping () -> ()) {
        guard repo.hasIssuesEnabled else { return }
        
        load(queryType: RepoIssuesQuery.self, repo: repo, after: issuesNextPage, containerWidth: containerWidth) { [weak self] result in
            switch result {
            case .error:
                completion()
            case .success(let payload):
                if let models = payload.models, models.count > 0 {
                    self?.issues += models
                }
                
                self?.issuesNextPage = payload.nextPage
                completion()
            }
        }
    }
    
    func loadMorePullRequests(containerWidth: CGFloat, completion: @escaping () -> ()) {
        load(queryType: RepoPullRequestsQuery.self, repo: repo, after: pullRequestsNextPage, containerWidth: containerWidth) { [weak self] result in
            switch result {
            case .error:
                completion()
            case .success(let payload):
                if let models = payload.models, models.count > 0 {
                    self?.pullRequests += models
                }
                
                self?.pullRequestsNextPage = payload.nextPage
                completion()
            }
        }
    }
    
    func load(containerWidth: CGFloat, completion: @escaping () -> ()) {
        var expectedResponseCount = repo.hasIssuesEnabled ? 2 : 1
    
        let checkResponses = {
            expectedResponseCount -= 1
            
            guard expectedResponseCount == 0 else { return }
            completion()
        }
        
        loadMoreIssues(containerWidth: containerWidth, completion: checkResponses)
        loadMorePullRequests(containerWidth: containerWidth, completion: checkResponses)
    }
    
}
