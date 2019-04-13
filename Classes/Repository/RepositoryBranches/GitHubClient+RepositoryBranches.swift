//
//  GitHubClient+RepoBranches.swift
//  Freetime
//
//  Created by B_Litwin on 9/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import GitHubAPI
import Apollo

private extension FetchRepositoryBranchesQuery.Data {

    func branches() -> [String] {
        var branches: [String] = []
        repository?.refs.map { edges in
            edges.edges.map { edge in
                branches += edge.compactMap {
                    $0?.node?.name
                }
            }
        }
        return branches
    }

    func nextPageToken() -> String? {
        guard repository?.refs?.pageInfo.hasNextPage == true else { return nil }
        return repository?.refs?.pageInfo.endCursor
    }

}

extension GithubClient {

    struct RepositoryBranchesPayload {
        let branches: [String]
        let nextPage: String?
    }

    func fetchRepositoryBranches(owner: String,
                                 repo: String,
                                 nextPage: String?,
                                 completion: @escaping (Result<RepositoryBranchesPayload>) -> Void
    ) {
        let query = FetchRepositoryBranchesQuery(owner: owner, name: repo, after: nextPage)
        client.query(query, result: { $0 }, completion: { result in

        switch result {
        case .failure(let error):
                completion(.error(error))

        case .success(let data):
            let payload = RepositoryBranchesPayload(
                branches: data.branches(),
                nextPage: data.nextPageToken()
            )
            completion(.success(payload))
            }
        })
    }
}
