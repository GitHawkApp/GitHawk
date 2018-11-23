//
//  BookmarkCloudMigrator.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/23/18.
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

final class BookmarkCloudMigrator {

    private let oldStore: BookmarkStore
    private let client: Client

    init(oldStore: BookmarkStore, client: Client) {
        self.oldStore = oldStore
        self.client = client
    }

    func sync() {
        let subQueries: [String] = oldStore.values.compactMap {
            switch $0.type {
            case .commit, .release, .securityVulnerability: return nil
            case .issue, .pullRequest:
                let key = "\($0.owner)\($0.name)\($0.number)".graphQLSafeKey
                return """
                \(key): repository(owner: "\($0.owner)", name: "\($0.name)") {
                    issueOrPullRequest(number: \($0.number)) {
                        ... on Issue { id }
                        ... on PullRequest { id }
                    }
                }
                """
            case .repo:
                let key = "\($0.owner)\($0.name)".graphQLSafeKey
                return """
                \(key): repository(owner: "\($0.owner)", name: "\($0.name)") { id }
                """
            }
        }
        let query = "query{\(subQueries.joined(separator: " "))}"
        client.send(ManualGraphQLRequest(query: query)) { [weak self] result in
            switch result {
            case .success(let json):
                self?.handle(json: json.data)
            case .failure(let error):
                print(error?.localizedDescription ?? "Unknown error fetching bookmark items")
            }
        }
    }

    private func handle(json: [String: Any]) {
        let ids: [String] = json.compactMap {
            guard let item = $0.value as? [String: Any] else { return nil }
            if let issueOrPullRequest = item["issueOrPullRequest"] as? [String: Any] {
                return issueOrPullRequest["id"] as? String
            }
            // repository
            return item["id"] as? String
        }
        print(ids)
    }

}
