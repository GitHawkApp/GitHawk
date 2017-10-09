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
    func summaryTypes(from data: GraphQLSelectionSet) -> [RepositoryIssueSummaryType]
    func nextPageToken(from data: GraphQLSelectionSet) -> String?
}

extension RepoIssuePagesQuery: RepositoryQuery {

    func summaryTypes(from data: GraphQLSelectionSet) -> [RepositoryIssueSummaryType] {
        guard let issues = data as? Data else { return [] }
        return issues.repository?.issues.nodes?.flatMap { $0 } ?? []
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
        return prs.repository?.pullRequests.nodes?.flatMap { $0 } ?? []
    }

    func nextPageToken(from data: GraphQLSelectionSet) -> String? {
        guard let prs = data as? RepoPullRequestPagesQuery.Data else { return nil }
        guard let pageInfo = prs.repository?.pullRequests.pageInfo, pageInfo.hasNextPage else { return nil }
        return pageInfo.endCursor
    }

}

func createSummaryModel(_ node: RepositoryIssueSummaryType, containerWidth: CGFloat) -> RepositoryIssueSummaryModel? {
    guard let date = GithubAPIDateFormatter().date(from: node.repoEventFields.createdAt)
        else { return nil }

    let attributes = [
        NSAttributedStringKey.font: Styles.Fonts.body,
        NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color
    ]
    let title = NSAttributedStringSizing(
        containerWidth: containerWidth,
        attributedText: NSAttributedString(string: node.title, attributes: attributes),
        inset: RepositorySummaryCell.titleInset
    )
    return RepositoryIssueSummaryModel(
        id: node.id,
        title: title,
        number: node.number,
        created: date,
        author: node.repoEventFields.author?.login ?? Constants.unknown,
        status: node.status,
        pullRequest: node.pullRequest
    )
}

func createSummaryModel(
    query: RepositoryQuery,
    data: GraphQLSelectionSet,
    containerWidth: CGFloat
    ) -> (models: [RepositoryIssueSummaryModel], nextPage: String?) {
    let nextPage = query.nextPageToken(from: data)
    let models: [RepositoryIssueSummaryModel] = query.summaryTypes(from: data).flatMap { (node: RepositoryIssueSummaryType) in
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
        let models: [RepositoryIssueSummaryModel]
        let nextPage: String?
    }

    private func loadPage<T: GraphQLQuery>(
        query: T,
        containerWidth: CGFloat,
        completion: @escaping (Result<RepositoryPayload>) -> ()
    ) where T: RepositoryQuery {
        githubClient.fetch(query: query) { (result, error) in
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

    func loadIssues(
        nextPage: String? = nil,
        containerWidth: CGFloat,
        completion: @escaping (Result<RepositoryPayload>) -> ()
        ) {
        loadPage(
            query: RepoIssuePagesQuery(owner: owner, name: name, after: nextPage, page_size: 100),
            containerWidth: containerWidth,
            completion: completion
        )
    }

    func loadPullRequests(
        nextPage: String? = nil,
        containerWidth: CGFloat,
        completion: @escaping (Result<RepositoryPayload>) -> ()
        ) {
        loadPage(
            query: RepoPullRequestPagesQuery(owner: owner, name: name, after: nextPage, page_size: 100),
            containerWidth: containerWidth,
            completion: completion
        )
    }

    func fetchReadme(
        completion: @escaping (Result<String>) -> ()
        ) {
        githubClient.request(GithubClient.Request(
            path: "repos/\(owner)/\(name)/readme",
            completion: { (response, _) in
                if let json = response.value as? [String: Any],
                    let content = json["content"] as? String,
                    let data = Data(base64Encoded: content, options: [.ignoreUnknownCharacters]),
                    let text = String(data: data, encoding: .utf8) {
                    completion(.success(text))
                } else {
                    completion(.error(response.error))
                }
        }))
    }
    
}
