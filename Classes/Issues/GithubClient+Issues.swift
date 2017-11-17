//
//  GithubClient+Issues.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

private func uniqueAutocompleteUsers(
    left: [AutocompleteUser],
    right: [AutocompleteUser]
    ) -> [AutocompleteUser] {
    var uniqueUsers = Set<String>()
    var mentionableUsers = [AutocompleteUser]()

    for user in left {
        if !uniqueUsers.contains(user.login) {
            uniqueUsers.insert(user.login)
            mentionableUsers.append(user)
        }
    }

    for user in right {
        if !uniqueUsers.contains(user.login) {
            uniqueUsers.insert(user.login)
            mentionableUsers.append(user)
        }
    }

    return mentionableUsers
}

extension GithubClient {

    func fetch(
        owner: String,
        repo: String,
        number: Int,
        width: CGFloat,
        prependResult: IssueResult?,
        completion: @escaping (Result<(IssueResult, [AutocompleteUser])>) -> Void
        ) {

        let query = IssueOrPullRequestQuery(
            owner: owner,
            repo: repo,
            number: number,
            page_size: 30,
            before: prependResult?.minStartCursor
        )

        let cache = self.cache

        fetch(query: query) { (result, error) in
            let repository = result?.data?.repository
            let issueOrPullRequest = repository?.issueOrPullRequest
            if let issueType: IssueType = issueOrPullRequest?.asIssue ?? issueOrPullRequest?.asPullRequest {
                DispatchQueue.global().async {

                    let status: IssueStatus = issueType.merged ? .merged : issueType.closableFields.closed ? .closed : .open

                    let rootComment = createCommentModel(
                        id: issueType.id,
                        commentFields: issueType.commentFields,
                        reactionFields: issueType.reactionFields,
                        width: width,
                        owner: owner,
                        repo: repo,
                        threadState: .single,
                        viewerCanUpdate: issueType.viewerCanUpdate,
                        viewerCanDelete: false, // Root comment can not be deleted
                        isRoot: true
                    )

                    let timeline = issueType.timelineViewModels(owner: owner, repo: repo, width: width)

                    // append the issue author for autocomplete
                    var mentionedUsers = timeline.mentionedUsers
                    if let details = rootComment?.details {
                        mentionedUsers.append(AutocompleteUser(
                            avatarURL: details.avatarURL,
                            login: details.login
                        ))
                    }

                    let mentionableUsers = uniqueAutocompleteUsers(
                        left: mentionedUsers,
                        right: repository?.mentionableUsers.autocompleteUsers ?? []
                    )

                    let paging = issueType.headPaging
                    let newPage = IssueTimelinePage(
                        startCursor: paging.hasPreviousPage ? paging.startCursor : nil,
                        viewModels: timeline.models
                    )

                    let milestoneModel: Milestone?
                    if let milestone = issueType.milestoneFields {
                        let dueOn: Date?
                        if let date = milestone.dueOn {
                            dueOn = GithubAPIDateFormatter().date(from: date)
                        } else {
                            dueOn = nil
                        }
                        milestoneModel = Milestone(
                            number: milestone.number,
                            title: milestone.title,
                            dueOn: dueOn
                        )
                    } else {
                        milestoneModel = nil
                    }

                    let canAdmin = repository?.viewerCanAdminister ?? false

                    let issueResult = IssueResult(
                        id: issueType.id,
                        pullRequest: issueType.pullRequest,
                        status: IssueStatusModel(status: status, pullRequest: issueType.pullRequest, locked: issueType.locked),
                        title: titleStringSizing(title: issueType.title, width: width),
                        labels: IssueLabelsModel(labels: issueType.labelableFields.issueLabelModels),
                        assignee: createAssigneeModel(assigneeFields: issueType.assigneeFields),
                        rootComment: rootComment,
                        reviewers: issueType.reviewRequestModel,
                        milestone: milestoneModel,
                        timelinePages: [newPage] + (prependResult?.timelinePages ?? []),
                        viewerCanUpdate: issueType.viewerCanUpdate,
                        hasIssuesEnabled: repository?.hasIssuesEnabled ?? false,
                        viewerCanAdminister: canAdmin,
                        defaultBranch: repository?.defaultBranchRef?.name ?? "master"
                    )

                    DispatchQueue.main.async {
                        // update the cache so all listeners receive the new model
                        cache.set(value: issueResult)

                        completion(.success((issueResult, mentionableUsers)))
                    }
                }
            } else {
                completion(.error(nil))
            }
            ShowErrorStatusBar(graphQLErrors: result?.errors, networkError: error)
        }
    }

    func react(
        subjectID: String,
        content: ReactionContent,
        isAdd: Bool,
        completion: @escaping (IssueCommentReactionViewModel?) -> Void
        ) {
        if isAdd {
            perform(mutation: AddReactionMutation(subject_id: subjectID, content: content)) { (result, error) in
                if let reactionFields = result?.data?.addReaction?.subject.fragments.reactionFields {
                    completion(createIssueReactions(reactions: reactionFields))
                } else {
                    completion(nil)
                }
                ShowErrorStatusBar(graphQLErrors: result?.errors, networkError: error)
            }
        } else {
            perform(mutation: RemoveReactionMutation(subject_id: subjectID, content: content)) { (result, error) in
                if let reactionFields = result?.data?.removeReaction?.subject.fragments.reactionFields {
                    completion(createIssueReactions(reactions: reactionFields))
                } else {
                    completion(nil)
                }
                ShowErrorStatusBar(graphQLErrors: result?.errors, networkError: error)
            }
        }
    }

    func setStatus(
        previous: IssueResult,
        owner: String,
        repo: String,
        number: Int,
        close: Bool
        ) {
        let newStatus = IssueStatusModel(
            status: close ? .closed : .open,
            pullRequest: previous.status.pullRequest,
            locked: previous.status.locked
        )
        let newEvent = IssueStatusEventModel(
            id: UUID().uuidString,
            actor: userSession?.username ?? Constants.Strings.unknown,
            commitHash: nil,
            date: Date(),
            status: close ? .closed : .reopened,
            pullRequest: previous.pullRequest
        )
        let optimisticResult = previous.updated(
            status: newStatus,
            timelinePages: previous.timelinePages(appending: [newEvent])
        )

        let cache = self.cache

        // optimistically update the cache, listeners can react as appropriate
        cache.set(value: optimisticResult)

        let stateString = close ? "closed" : "open"

        // https://developer.github.com/v3/issues/#edit-an-issue
        request(Request(
            path: "repos/\(owner)/\(repo)/issues/\(number)",
            method: .patch,
            parameters: [ "state": stateString ],
            completion: { (response, _) in
                // rewind to a previous object if response isn't a success
                if response.response?.statusCode != 200 {
                    cache.set(value: previous)
                    ToastManager.showGenericError()
                }
        }))
    }

    func deleteComment(owner: String, repo: String, commentID: Int, completion: @escaping (Result<Bool>) -> Void) {
        request(Request(path: "repos/\(owner)/\(repo)/issues/comments/\(commentID)", method: .delete, completion: { (response, _) in
            // As per documentation this endpoint returns no content, so all we can validate is that
            // the status code is "204 No Content".
            if response.response?.statusCode == 204 {
                completion(.success(true))
            } else {
                completion(.error(response.error))
            }
        }))
    }

    func setLocked(
        previous: IssueResult,
        owner: String,
        repo: String,
        number: Int,
        locked: Bool,
        completion: ((Result<Bool>) -> Void)? = nil
        ) {
        let newStatus = IssueStatusModel(
            status: previous.status.status,
            pullRequest: previous.status.pullRequest,
            locked: locked
        )
        let newEvent = IssueStatusEventModel(
            id: UUID().uuidString,
            actor: userSession?.username ?? Constants.Strings.unknown,
            commitHash: nil,
            date: Date(),
            status: locked ? .locked : .unlocked,
            pullRequest: previous.pullRequest
        )
        let optimisticResult = previous.updated(
            status: newStatus,
            timelinePages: previous.timelinePages(appending: [newEvent])
        )

        let cache = self.cache

        // optimistically update the cache, listeners can react as appropriate
        cache.set(value: optimisticResult)

        request(Request(
            path: "repos/\(owner)/\(repo)/issues/\(number)/lock",
            method: locked ? .put : .delete,
            completion: { (response, _) in
                // As per documentation this endpoint returns no content, so all we can validate is that
                // the status code is "204 No Content".
                if response.response?.statusCode == 204 {
                    completion?(.success(true))
                } else {
                    cache.set(value: previous)
                    ToastManager.showGenericError()
                    completion?(.error(nil))
                }
        }))
    }

    func fetchViewerCollaborator(
        owner: String,
        repo: String,
        completion: @escaping (Result<Bool>) -> Void
        ) {
        guard let viewer = userSession?.username else {
            completion(.error(nil))
            return
        }

        // https://developer.github.com/v3/repos/collaborators/#review-a-users-permission-level
        request(Request(
            path: "repos/\(owner)/\(repo)/collaborators/\(viewer)/permission",
            headers: ["Accept": "application/vnd.github.hellcat-preview+json"],
            completion: { (response, _) in
                // documentation states that collab = 204
                if let json = response.value as? [String: Any],
                    let permission = json["permission"] as? String {
                    completion(.success(permission == "admin" || permission == "write"))
                } else {
                    completion(.error(response.error))
                }
        }))
    }

    func mutateLabels(
        previous: IssueResult,
        owner: String,
        repo: String,
        number: Int,
        labels: [RepositoryLabel]
        ) {
        let optimistic = previous.updated(labels: IssueLabelsModel(labels: labels))

        let cache = self.cache
        cache.set(value: optimistic)

        request(GithubClient.Request(
            path: "repos/\(owner)/\(repo)/issues/\(number)",
            method: .patch,
            parameters: ["labels": labels.map { $0.name }]
        ) { (response, _) in
            if let statusCode = response.response?.statusCode, statusCode != 200 {
                cache.set(value: previous)
                if statusCode == 403 {
                    ToastManager.showPermissionsError()
                } else {
                    ToastManager.showGenericError()
                }
            }
        })
    }

}
