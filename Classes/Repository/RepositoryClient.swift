//
//  RepositoryClient.swift
//  Freetime
//
//  Created by Sherlock, James on 30/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import Apollo
import StyledTextKit
import Squawk

protocol RepositoryQuery {
    // generated queries should share the same init
    func summaryTypes(from data: GraphQLSelectionSet) -> [RepositoryIssueSummaryType]
    func nextPageToken(from data: GraphQLSelectionSet) -> String?
}

extension RepoIssuePagesQuery: RepositoryQuery {

    func summaryTypes(from data: GraphQLSelectionSet) -> [RepositoryIssueSummaryType] {
        guard let issues = data as? Data else { return [] }
        return issues.repository?.issues.nodes?.compactMap { $0 } ?? []
    }

    func nextPageToken(from data: GraphQLSelectionSet) -> String? {
        guard let issues = data as? Data else { return nil }
        guard let pageInfo = issues.repository?.issues.pageInfo, pageInfo.hasNextPage else { return nil }
        return pageInfo.endCursor
    }

}

extension RepoPullRequestPagesQuery: RepositoryQuery {

    func summaryTypes(from data: GraphQLSelectionSet) -> [RepositoryIssueSummaryType] {
        guard let prs = data as? RepoPullRequestPagesQuery.Data else { return [] }
        return prs.repository?.pullRequests.nodes?.compactMap { $0 } ?? []
    }

    func nextPageToken(from data: GraphQLSelectionSet) -> String? {
        guard let prs = data as? RepoPullRequestPagesQuery.Data else { return nil }
        guard let pageInfo = prs.repository?.pullRequests.pageInfo, pageInfo.hasNextPage else { return nil }
        return pageInfo.endCursor
    }

}

extension RepoSearchPagesQuery: RepositoryQuery {

    func summaryTypes(from data: GraphQLSelectionSet) -> [RepositoryIssueSummaryType] {
        guard let results = data as? RepoSearchPagesQuery.Data else { return [] }
        return results.search.nodes?.compactMap { $0?.asIssue ?? $0?.asPullRequest } ?? []
    }

    func nextPageToken(from data: GraphQLSelectionSet) -> String? {
        guard let results = data as? RepoSearchPagesQuery.Data,
            results.search.pageInfo.hasNextPage else { return nil }
        return results.search.pageInfo.endCursor
    }

}

func createSummaryModel(
    _ node: RepositoryIssueSummaryType,
    contentSizeCategory: UIContentSizeCategory,
    containerWidth: CGFloat
    ) -> RepositoryIssueSummaryModel? {
    guard let date = node.repoEventFields.createdAt.githubDate else { return nil }

    let title = StyledTextBuilder(styledText: StyledText(
        text: node.title,
        style: Styles.Text.body.with(foreground: Styles.Colors.Gray.dark.color)
    )).build()
    let string = StyledTextRenderer(
        string: title,
        contentSizeCategory: contentSizeCategory,
        inset: RepositorySummaryCell.titleInset
    ).warm(width: containerWidth)

    return RepositoryIssueSummaryModel(
        id: node.id,
        title: string,
        number: node.number,
        created: date,
        author: node.repoEventFields.author?.login ?? Constants.Strings.unknown,
        status: node.status,
        pullRequest: node.pullRequest,
        labels: node.labelableFields.issueLabelModels
    )
}

func createSummaryModel(
    query: RepositoryQuery,
    data: GraphQLSelectionSet,
    contentSizeCategory: UIContentSizeCategory,
    containerWidth: CGFloat
    ) -> (models: [RepositoryIssueSummaryModel], nextPage: String?) {
    let nextPage = query.nextPageToken(from: data)
    let models: [RepositoryIssueSummaryModel] = query.summaryTypes(from: data).compactMap { (node: RepositoryIssueSummaryType) in
        return createSummaryModel(node, contentSizeCategory: contentSizeCategory, containerWidth: containerWidth)
    }.sorted(by: {
        $0.created > $1.created 
    })
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
        let models: [RepositoryIssueSummaryModel]
        let nextPage: String?
    }

    private func loadPage<T: GraphQLQuery>(
        query: T,
        containerWidth: CGFloat,
        completion: @escaping (Result<RepositoryPayload>) -> Void
    ) where T: RepositoryQuery {
        let contentSizeCategory = UIContentSizeCategory.preferred
        githubClient.client.query(query, result: { $0 }, completion: { result in
            switch result {
            case .failure(let error):
                Squawk.show(error: error)
                completion(.error(error))
            case .success(let data):
                DispatchQueue.global().async {
                    // jump to a bg queue to parse models and presize text
                    let summary = createSummaryModel(
                        query: query,
                        data: data,
                        contentSizeCategory: contentSizeCategory,
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
        })
    }

    func loadIssues(
        nextPage: String? = nil,
        containerWidth: CGFloat,
        completion: @escaping (Result<RepositoryPayload>) -> Void
        ) {
        loadPage(
            query: RepoIssuePagesQuery(owner: owner, name: name, after: nextPage, page_size: 30),
            containerWidth: containerWidth,
            completion: completion
        )
    }

    func loadPullRequests(
        nextPage: String? = nil,
        containerWidth: CGFloat,
        completion: @escaping (Result<RepositoryPayload>) -> Void
        ) {
        loadPage(
            query: RepoPullRequestPagesQuery(owner: owner, name: name, after: nextPage, page_size: 30),
            containerWidth: containerWidth,
            completion: completion
        )
    }

    func searchIssues(
        query: String,
        nextPage: String? = nil,
        containerWidth: CGFloat,
        completion: @escaping (Result<RepositoryPayload>) -> Void
        ) {
        loadPage(
            query: RepoSearchPagesQuery(query: query, after: nextPage, page_size: 30),
            containerWidth: containerWidth,
            completion: completion
        )
    }

}
