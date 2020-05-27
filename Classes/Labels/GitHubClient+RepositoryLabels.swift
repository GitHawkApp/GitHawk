//
//  GitHubClient+RepositoryLabels.swift
//  Freetime
//
//  Created by Quentin Dreyer on 05/03/2020.
//  Copyright © 2020 Ryan Nystrom. All rights reserved.
//

import GitHubAPI
import Apollo

private extension FetchRepositoryLabelsQuery.Data {

    func labels() -> [RepositoryLabel] {
        var labels: [RepositoryLabel] = []
        repository?.labels.map { nodes in
            nodes.nodes.map { node in
                labels += node.compactMap {
                    guard let label = $0 else { return nil }
                    return RepositoryLabel(color: label.color, name: label.name)
                }
            }
        }
        return labels
    }

    func nextPageToken() -> String? {
        guard repository?.labels?.pageInfo.hasNextPage == true else { return nil }
        return repository?.labels?.pageInfo.endCursor
    }

}

extension GithubClient {

    struct RepositoryLabelsPayload {
        let labels: [RepositoryLabel]
        let nextPage: String?
    }

    func fetchRepositoryLabels(owner: String,
                                 repo: String,
                                 nextPage: String?,
                                 completion: @escaping (Result<RepositoryLabelsPayload>) -> Void
    ) {
        let query = FetchRepositoryLabelsQuery(owner: owner, repo: repo, after: nextPage)
        client.query(query, result: { $0 }, completion: { result in

        switch result {
        case .failure(let error):
                completion(.error(error))

        case .success(let data):
            let payload = RepositoryLabelsPayload(
                labels: data.labels(),
                nextPage: data.nextPageToken()
            )
            completion(.success(payload))
            }
        })
    }
}
