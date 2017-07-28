//
//  GithubClient+Search.swift
//  Freetime
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension GithubClient {
    
    enum SearchResultType {
        case error
        case success(String?, [SearchResult])
    }
    
    func search(query: String, before: String? = nil, completion: @escaping (SearchResultType) -> ()) {
        let query = SearchReposQuery(search: query, before: before)
        
        apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { (result, error) in
            guard error == nil, result?.errors == nil else {
                ShowErrorStatusBar(graphQLErrors: result?.errors, networkError: error)
                return
            }
            
            DispatchQueue.global().async {
                var builder = [SearchResult]()
                
                result?.data?.search.nodes?.forEach {
                    guard let repo = $0?.asRepository else { return }
                    builder.append(SearchResult(repo: repo))
                }
                
                DispatchQueue.main.async {
                    let nextPage: String? = {
                        guard let pageInfo = result?.data?.search.pageInfo, pageInfo.hasNextPage else {
                            return nil
                        }
                        
                        return pageInfo.endCursor
                    }()
                    
                    completion(.success(nextPage, builder))
                }
            }
        }
    }
    
}
