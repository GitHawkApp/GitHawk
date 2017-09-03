//
//  RepositoryClient.swift
//  Freetime
//
//  Created by Sherlock, James on 30/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Apollo

protocol RepositoryQuery {
    // generated queries should share the same init
    func summaryTypes(from data: GraphQLMappable) -> [IssueSummaryType]
    func nextPageToken(from data: GraphQLMappable) -> String?
}

extension RepoIssuePagesQuery: RepositoryQuery {

    func summaryTypes(from data: GraphQLMappable) -> [IssueSummaryType] {
        guard let issues = data as? Data else { return [] }
        return issues.repository?.issues.nodes?.flatMap { $0 } ?? []
    }

    func nextPageToken(from data: GraphQLMappable) -> String? {
        guard let issues = data as? Data else { return nil }
        guard let pageInfo = issues.repository?.issues.pageInfo, pageInfo.hasNextPage else { return nil }
        return pageInfo.endCursor
    }

}

extension RepoPullRequestPagesQuery: RepositoryQuery {

    func summaryTypes(from data: GraphQLMappable) -> [IssueSummaryType] {
        guard let prs = data as? RepoPullRequestPagesQuery.Data else { return [] }
        return prs.repository?.pullRequests.nodes?.flatMap { $0 } ?? []
    }

    func nextPageToken(from data: GraphQLMappable) -> String? {
        guard let prs = data as? RepoPullRequestPagesQuery.Data else { return nil }
        guard let pageInfo = prs.repository?.pullRequests.pageInfo, pageInfo.hasNextPage else { return nil }
        return pageInfo.endCursor
    }

}

func createSummaryModel(_ node: IssueSummaryType, containerWidth: CGFloat) -> IssueSummaryModel? {
    guard let date = GithubAPIDateFormatter().date(from: node.repoEventFields.createdAt)
        else { return nil }

    let attributes = [
        NSFontAttributeName: Styles.Fonts.title,
        NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color
    ]
    let title = NSAttributedStringSizing(
        containerWidth: containerWidth,
        attributedText: NSAttributedString(string: node.title, attributes: attributes),
        inset: RepositorySummaryCell.titleInset
    )
    return IssueSummaryModel(
        id: node.id,
        title: title,
        number: node.number,
        created: date,
        author: node.repoEventFields.author?.login ?? Strings.unknown,
        status: node.status,
        pullRequest: node.pullRequest
    )
}

func createSummaryModel(
    query: RepositoryQuery,
    data: GraphQLMappable,
    containerWidth: CGFloat
    ) -> (models: [IssueSummaryModel], nextPage: String?) {
    let nextPage = query.nextPageToken(from: data)
    let models: [IssueSummaryModel] = query.summaryTypes(from: data).flatMap { (node: IssueSummaryType) in
        return createSummaryModel(node, containerWidth: containerWidth)
    }
    return (models, nextPage)
}

final class RepositoryClient {

    let githubClient: GithubClient

    private let owner: String
    private let name: String

    init(githubClient: GithubClient, owner: String, name: String) {
        self.githubClient = githubClient
        self.owner = owner
        self.name = name
    }

    struct RepositoryPayload {
        let models: [IssueSummaryModel]
        let nextPage: String?
    }

    private func loadPage<T: GraphQLQuery>(
        query: T,
        containerWidth: CGFloat,
        completion: @escaping (Result<RepositoryPayload>) -> ()
    ) where T: RepositoryQuery {
        githubClient.apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { (result, error) in
            guard error == nil, result?.errors == nil, let data = result?.data else {
                ShowErrorStatusBar(graphQLErrors: result?.errors, networkError: error)
                completion(.error(nil))
                return
            }

            DispatchQueue.global().async {
                // jump to a bg queue to parse models and presize text
                let summary = createSummaryModel(
                    query: query,
                    data: data,
                    containerWidth: containerWidth
                )

                DispatchQueue.main.async {
                    completion(.success(RepositoryPayload(
                        models: summary.models,
                        nextPage: summary.nextPage
                    )))
                }
            }
        }
    }

    func loadMoreIssues(
        nextPage: String?,
        containerWidth: CGFloat,
        completion: @escaping (Result<RepositoryPayload>) -> ()
        ) {
        loadPage(
            query: RepoIssuePagesQuery(owner: owner, name: name, after: nextPage, pageSize: 100),
            containerWidth: containerWidth,
            completion: completion
        )
    }

    func loadMorePullRequests(
        nextPage: String?,
        containerWidth: CGFloat,
        completion: @escaping (Result<RepositoryPayload>) -> ()
        ) {
        loadPage(
            query: RepoPullRequestPagesQuery(owner: owner, name: name, after: nextPage, pageSize: 100),
            containerWidth: containerWidth,
            completion: completion
        )
    }

    struct RepositoryDetailsPayload {
        let issues: RepositoryPayload
        let pullRequests: RepositoryPayload
    }

    func load(
        containerWidth: CGFloat,
        completion: @escaping (Result<RepositoryDetailsPayload>) -> ()
        ) {

        let query = RepoDetailsQuery(owner: owner, name: name, pageSize: 100)
        githubClient.apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { (result, error) in
            guard error == nil, result?.errors == nil, let data = result?.data else {
                ShowErrorStatusBar(graphQLErrors: result?.errors, networkError: error)
                completion(.error(nil))
                return
            }

            let issueNodes = (data.repository?.issues.nodes ?? []).flatMap { $0 }
            let issues = issueNodes.flatMap { (node: IssueSummaryType) in
                return createSummaryModel(node, containerWidth: containerWidth)
            }
            let issueNextPage: String?
            if let pageInfo = data.repository?.issues.pageInfo, pageInfo.hasNextPage == true {
                issueNextPage = pageInfo.endCursor
            } else {
                issueNextPage = nil
            }

            let prNodes = (data.repository?.pullRequests.nodes ?? []).flatMap { $0 }
            let prs = prNodes.flatMap { (node: IssueSummaryType) in
                return createSummaryModel(node, containerWidth: containerWidth)
            }
            let prNextPage: String?
            if let pageInfo = data.repository?.issues.pageInfo, pageInfo.hasNextPage == true {
                prNextPage = pageInfo.endCursor
            } else {
                prNextPage = nil
            }

            completion(.success(RepositoryDetailsPayload(
                issues: RepositoryPayload(models: issues, nextPage: issueNextPage),
                pullRequests: RepositoryPayload(models: prs, nextPage: prNextPage)
            )))
        }
    }
    
}
