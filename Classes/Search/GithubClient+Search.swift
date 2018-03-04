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
        completion: @escaping (SearchResultType) -> Void
        ) -> Cancellable {
        let query = SearchReposQuery(search: query, before: before)
        return client.query(query, result: { $0 }) { result in
            switch result {
            case .failure(let error):
                completion(.error(error))
                ToastManager.showGenericError()
            case .success(let data):
                DispatchQueue.global().async {
                    var builder = [SearchRepoResult]()

                    data.search.nodes?.forEach {
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
                            primaryLanguage: primaryLanguage,
                            defaultBranch: repo.defaultBranchRef?.name ?? "master"
                        )
                        builder.append(model)
                    }

                    DispatchQueue.main.async {
                        let nextPage: String?
                        if data.search.pageInfo.hasNextPage {
                            nextPage = data.search.pageInfo.endCursor
                        } else {
                            nextPage = nil
                        }
                        completion(.success(nextPage, builder))
                    }
                }
            }
        }
    }

}
