//
//  GitHubClient+Bookmarks.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubAPI

private extension String {
    var graphQLSafeKey: String {
        return "gql" + components(separatedBy: CharacterSet.alphanumerics.inverted)
            .joined()
    }
}

private func bookmarkGraphQLIDs(from json: [String: Any]) -> [String] {
    return json.compactMap {
        guard let item = $0.value as? [String: Any] else { return nil }
        if let issueOrPullRequest = item["issueOrPullRequest"] as? [String: Any] {
            return issueOrPullRequest["id"] as? String
        }
        // repository
        return item["id"] as? String
    }
}

extension GithubClient: BookmarkViewController2.Client {

    func fetch(
        bookmarks: [BookmarkCloudMigratorClientBookmarks],
        completion: @escaping (BookmarkCloudMigratorClientResult) -> Void
        ) {
        let subQueries: [String] = bookmarks.map {
            switch $0 {
            case .issueOrPullRequest(let owner, let name, let number):
                let key = "\(owner)\(name)\(number)".graphQLSafeKey
                return """
                    \(key): repository(owner: "\(owner)", name: "\(name)") {
                        issueOrPullRequest(number: \(number)) {
                            ... on Issue { id }
                            ... on PullRequest { id }
                        }
                    }
                """
            case .repo(let owner, let name):
                let key = "\(owner)\(name)".graphQLSafeKey
                return """
                    \(key): repository(owner: "\(owner)", name: "\(name)") { id }
                """
            }
        }
        let query = "query{\(subQueries.joined(separator: " "))}"
        client.send(ManualGraphQLRequest(query: query)) { result in
            switch result {
            case .success(let json):
                let ids = bookmarkGraphQLIDs(from: json.data)
                completion(.success(ids))
            case .failure(let error):
                completion(.error(error))
            }
        }
    }

    func fetch(
        graphQLIDs: [String],
        completion: @escaping (Result<[BookmarkModelType]>) -> Void
        ) {
        let contentSizeCategory = UIApplication.shared.preferredContentSizeCategory
        client.query(BookmarkNodesQuery(ids: graphQLIDs), result: { $0 }, completion: { result in
            switch result {
            case .failure(let error):
                completion(.error(error))
            case .success(let data):
                var models = [BookmarkModelType]()
                data.nodes.forEach {
                    if let issue = $0?.asIssue {
                        models.append(.issue(BookmarkIssueViewModel(
                            owner: issue.repository.owner.login,
                            name: issue.repository.name,
                            number: issue.number,
                            isPullRequest: false,
                            state: issue.issueState.rawValue,
                            title: issue.title,
                            contentSizeCategory: contentSizeCategory
                        )))
                    } else if let pr = $0?.asPullRequest {
                        models.append(.issue(BookmarkIssueViewModel(
                            owner: pr.repository.owner.login,
                            name: pr.repository.name,
                            number: pr.number,
                            isPullRequest: true,
                            state: pr.pullRequestState.rawValue,
                            title: pr.title,
                            contentSizeCategory: contentSizeCategory
                        )))
                    } else if let repo = $0?.asRepository {
                        models.append(.repo(RepositoryDetails(
                            owner: repo.owner.login,
                            name: repo.name
                        )))
                    }
                }
                completion(.success(models))
            }
        })
    }

}
