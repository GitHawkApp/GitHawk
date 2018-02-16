//
//  GithubClient+Merge.swift
//  Freetime
//
//  Created by Ryan Nystrom on 2/15/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

extension GithubClient {

    func merge(
        previous: IssueResult,
        owner: String,
        repo: String,
        number: Int,
        type: IssueMergeType
        ) {
        let newStatus = IssueStatusModel(
            status: .merged,
            pullRequest: previous.status.pullRequest,
            locked: previous.status.locked
        )
        let newEvent = IssueStatusEventModel(
            id: UUID().uuidString,
            actor: userSession?.username ?? Constants.Strings.unknown,
            commitHash: nil,
            date: Date(),
            status: .merged,
            pullRequest: previous.pullRequest
        )
        let optimisticResult = previous.updated(
            status: newStatus,
            timelinePages: previous.timelinePages(appending: [newEvent])
        )

        let cache = self.cache

        // optimistically update the cache, listeners can react as appropriate
        cache.set(value: optimisticResult)

        let methodString: String
        switch type {
        case .merge: methodString = "merge"
        case .rebase: methodString = "rebase"
        case .squash: methodString = "squash"
        }

        // https://developer.github.com/v3/issues/#edit-an-issue
        request(Request(
            path: "repos/\(owner)/\(repo)/pulls/\(number)/merge",
            method: .put,
            parameters: [ "merge_method": methodString ],
            completion: { (response, _) in
                // rewind to a previous object if response isn't a success
                if response.response?.statusCode != 200 {
                    cache.set(value: previous)
                    ToastManager.showGenericError()
                }
        }))
    }

}
