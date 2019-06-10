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

    let builder = StyledTextBuilder(styledText: StyledText(
        text: node.title,
        style: Styles.Text.body
    ))
    if let ciStatus = node.ciStatus {
        let iconName: String
        let color: UIColor
        switch ciStatus {
        case .pending:
            iconName = "primitive-dot"
            color = Styles.Colors.Yellow.medium.color
        case .failure:
            iconName = "x-small"
            color = Styles.Colors.Red.medium.color
        case .success:
            iconName = "check-small"
            color = Styles.Colors.Green.medium.color
        }
        if let icon = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate) {
            builder.save()
                .add(text: "\u{00A0}")
                .add(image: icon, attributes: [.foregroundColor: color])
                .restore()
        }
    }
    let string = StyledTextRenderer(
        string: builder.build(),
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
        labels: node.labelableFields.issueLabelModels,
        ciStatus: node.ciStatus
    )
}

func createSummaryModel(
    query: RepositoryQuery,
    data: GraphQLSelectionSet,
    contentSizeCategory: UIContentSizeCategory,
    containerWidth: CGFloat
    ) -> (models: [RepositoryIssueSummaryModel], nextPage: String?) {
    let nextPage = query.nextPageToken(from: data)
    let models = query.summaryTypes(from: data).compactMap { node in
        return createSummaryModel(
            node,
            contentSizeCategory: contentSizeCategory,
            containerWidth: containerWidth
        )
    }.sorted {$0.created > $1.created }
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
