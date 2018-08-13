//
//  GitHubClient+RepositoryFragmentType.swift
//  Freetime
//
//  Created by B_Litwin on 8/12/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import Apollo

extension GithubClient {
    
    enum RepositoryFragmentsResultType {
        case error(Error?)
        case success(String?, [RepositoryFragmentType])
    }
    
    func fetchRepositories<T: GraphQLQuery>(query: T,
                                            completion: @escaping (RepositoryFragmentsResultType) -> Void
        ) where T: UserProfileReposQuery {
        client.query(query, result: { $0 }) { result in
            switch result {
            case .failure(let error):
                //ToastManager.showGenericError()
                completion(.error(nil))
            
            case .success(let data):
                DispatchQueue.global().async {
                    let builder = query.repositoryFragments(from: data)
                    DispatchQueue.main.async {
                        let nextPage = query.nextPageToken(from: data)
                        completion(.success(nextPage, builder))
                    }
                }
            }
        }
    }
}
