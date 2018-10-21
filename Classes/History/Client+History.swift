//
//  Client+History.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/20/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubAPI

extension Client {

    func fetchHistory(
        owner: String,
        repo: String,
        branch: String,
        path: String?,
        cursor: String?,
        width: CGFloat,
        contentSizeCategory: UIContentSizeCategory,
        completion: @escaping (Result<([PathCommitModel], String?)>) -> Void
        ) {
        query(
            RepoFileHistoryQuery(
                owner: owner,
                name: repo,
                branch: branch,
                path: path,
                after: cursor,
                page_size: 20
            ),
            result: { $0 },
            completion: { result in
                switch result {
                case .failure(let error):
                    completion(.error(error))
                case .success(let data):
                    let commits = data.commits(width: width, contentSizeCategory: contentSizeCategory)
                    let nextPage: String?
                    if let pageInfo = data.repository?.object?.asCommit?.history.pageInfo,
                        pageInfo.hasNextPage {
                        nextPage = pageInfo.endCursor
                    } else {
                        nextPage = nil
                    }
                    completion(.success((commits, nextPage)))
                }
        })
    }

}
