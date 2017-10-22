//
//  GithubClient+Search.swift
//  Freetime
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import Apollo

extension GithubClient {
    
    enum SearchResultType {
        case error(Error?)
        case success(String?, [SearchRepoResult])
    }

    @discardableResult
    func search(
        query: String,
        before: String? = nil,
        containerWidth: CGFloat,
        completion: @escaping (SearchResultType) -> ()
        ) -> Cancellable {
        let query = SearchReposQuery(search: query, before: before)

        return fetch(query: query) { (result, error) in
            guard error == nil, result?.errors == nil else {
                if !isCancellationError(error) {
                    ShowErrorStatusBar(graphQLErrors: result?.errors, networkError: error)
                }
                completion(.error(error))
                return
            }
            
            DispatchQueue.global().async {
                var builder = [SearchRepoResult]()
                
                result?.data?.search.nodes?.forEach {
                    guard let repo = $0?.asRepository else { return }

                    let primaryLanguage: GithubLanguage?
                    if let language = repo.primaryLanguage {
                        primaryLanguage = GithubLanguage(name: language.name, color: language.color?.color)
                    } else {
                        primaryLanguage = nil
                    }

                    let model = SearchRepoResult(
                        id: repo.id,
                        owner: repo.owner.login,
                        name: repo.name,
                        description: repo.description ?? "",
                        stars: repo.stargazers.totalCount,
                        hasIssuesEnabled: repo.hasIssuesEnabled,
                        primaryLanguage: primaryLanguage
                    )
                    builder.append(model)
                }
                
                DispatchQueue.main.async {
                    let nextPage: String?
                    if let pageInfo = result?.data?.search.pageInfo, pageInfo.hasNextPage {
                        nextPage = pageInfo.endCursor
                    } else {
                        nextPage = nil
                    }
                    completion(.success(nextPage, builder))
                }
            }
        }
    }
    
}
