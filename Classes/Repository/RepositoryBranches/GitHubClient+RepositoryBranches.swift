//
//  GitHubClient+RepoBranches.swift
//  Freetime
//
//  Created by B_Litwin on 9/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import GitHubAPI

extension GithubClient {
    
    func fetchRepositoryBranches(owner: String,
                                 repo: String,
                                 completion: @escaping (Result<([String])>)->Void
    ) {
        let query = FetchRepositoryBranchesQuery(owner: owner, name: repo)
        client.query(query, result: { $0.repository }) { result in
        
        switch result {
        case .failure(let error):
                completion(.error(error))
    
        case .success(let repository):
            var branches: [String] = []
            repository.refs.map { edges in
                edges.edges.map { edge in
                    branches += edge.compactMap {
                        $0?.node?.name
                    }
                }
            }

            completion(.success(branches))
            }
        }
    }
}
