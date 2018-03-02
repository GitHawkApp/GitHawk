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
        type: IssueMergeType,
        error: @escaping () -> Void
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

        let methodString: String
        switch type {
        case .merge: methodString = "merge"
        case .rebase: methodString = "rebase"
        case .squash: methodString = "squash"
        }

        let cache = self.cache

        // https://developer.github.com/v3/issues/#edit-an-issue
        request(Request(
            client: userSession?.client,
            path: "repos/\(owner)/\(repo)/pulls/\(number)/merge",
            method: .put,
            parameters: [ "merge_method": methodString ],
            completion: { (response, _) in
                // rewind to a previous object if response isn't a success
                if response.response?.statusCode == 200 {
                    cache.set(value: optimisticResult)
                } else {
                    if let json = response.value as? [String:Any], let error = json["message"] as? String {
                        ToastManager.showError(message: error)
                    } else {
                        ToastManager.showGenericError()
                    }
                    error()
                }
        }))
    }

}
