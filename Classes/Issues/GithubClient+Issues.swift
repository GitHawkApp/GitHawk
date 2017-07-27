//
//  GithubClient+Issues.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

extension GithubClient {

    enum IssueResultType {
        case error
        case success(IssueResult)
    }

    func fetch(
        owner: String,
        repo: String,
        number: Int,
        width: CGFloat,
        completion: @escaping (IssueResultType) -> ()
        ) {

        let query = IssueOrPullRequestQuery(owner: owner, repo: repo, number: number, pageSize: 100)
        apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { (result, error) in
            let repository = result?.data?.repository
            let issueOrPullRequest = repository?.issueOrPullRequest
            if let issueType: IssueType = issueOrPullRequest?.asIssue ?? issueOrPullRequest?.asPullRequest {
                DispatchQueue.global().async {

                    let models = createViewModels(issue: issueType, width: width)
                    let mentionableUsers = repository?.mentionableUsers.autocompleteUsers ?? []

                    let paging = issueType.headPaging
                    let newPage = IssueTimelinePage(
                        startCursor: paging.hasPreviousPage ? paging.startCursor : nil,
                        viewModels: models.timeline
                    )

                    let result = IssueResult(
                        subjectId: issueType.id,
                        viewModels: models.viewModels,
                        mentionableUsers: mentionableUsers,
                        timelinePages: [newPage]
                    )

                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                }
            } else {
                completion(.error)
            }
            ShowErrorStatusBar(graphQLErrors: result?.errors, networkError: error)
        }
    }

    func react(
        subjectID: String,
        content: ReactionContent,
        isAdd: Bool,
        completion: @escaping (IssueCommentReactionViewModel?) -> ()
        ) {
        if isAdd {
            apollo.perform(mutation: AddReactionMutation(subjectId: subjectID, content: content)) { (result, error) in
                if let reactionFields = result?.data?.addReaction?.subject.fragments.reactionFields {
                    completion(createIssueReactions(reactions: reactionFields))
                } else {
                    completion(nil)
                }
                ShowErrorStatusBar(graphQLErrors: result?.errors, networkError: error)
            }
        } else {
            apollo.perform(mutation: RemoveReactionMutation(subjectId: subjectID, content: content)) { (result, error) in
                if let reactionFields = result?.data?.removeReaction?.subject.fragments.reactionFields {
                    completion(createIssueReactions(reactions: reactionFields))
                } else {
                    completion(nil)
                }
                ShowErrorStatusBar(graphQLErrors: result?.errors, networkError: error)
            }
        }
    }

}
