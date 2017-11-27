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
                        defaultBranch: repository?.defaultBranchRef?.name ?? "master",
                        changedFiles: issueType.changedFileCount
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

    enum CollaboratorPermission: String {
        case admin
        case write
        case read
        case none

        static func from(_ str: String) -> CollaboratorPermission {
            return CollaboratorPermission(rawValue: str) ?? .none
        }

        var canManage: Bool {
            switch self {
            case .admin, .write:
                return true
            case .read, .none:
                return false
            }
        }
    }

    func fetchViewerCollaborator(
        owner: String,
        repo: String,
        completion: @escaping (Result<CollaboratorPermission>) -> Void
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
                let statusCode = response.response?.statusCode
                if statusCode == 200,
                    let json = response.value as? [String: Any],
                    let permission = json["permission"] as? String {
                    completion(.success(CollaboratorPermission.from(permission)))
                } else if statusCode == 403 {
                    completion(.success(.none))
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
        guard let actor = userSession?.username else { return }

        let oldLabelNames = Set<String>(previous.labels.labels.map { $0.name })
        let newLabelNames = Set<String>(labels.map { $0.name })

        var newEvents = [IssueLabeledModel]()
        for newLabel in labels {
            if !oldLabelNames.contains(newLabel.name) {
                newEvents.append(IssueLabeledModel(
                    id: UUID().uuidString,
                    actor: actor,
                    title: newLabel.name,
                    color: newLabel.color,
                    date: Date(),
                    type: .added,
                    repoOwner: owner,
                    repoName: repo,
                    width: 0
                ))
            }
        }
        for oldLabel in previous.labels.labels {
            if !newLabelNames.contains(oldLabel.name) {
                newEvents.append(IssueLabeledModel(
                    id: UUID().uuidString,
                    actor: actor,
                    title: oldLabel.name,
                    color: oldLabel.color,
                    date: Date(),
                    type: .removed,
                    repoOwner: owner,
                    repoName: repo,
                    width: 0
                ))
            }
        }

        let optimistic = previous.updated(
            labels: IssueLabelsModel(labels: labels),
            timelinePages: previous.timelinePages(appending: newEvents)
        )

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

    func addAssignees(
        previous: IssueResult,
        owner: String,
        repo: String,
        number: Int,
        assignees: [IssueAssigneeViewModel]
        ) {
        guard let actor = userSession?.username else { return }

        let oldAssigness = Set<String>(previous.assignee.users.map { $0.login })
        let newAssignees = Set<String>(assignees.map { $0.login })

        var newEvents = [IssueRequestModel]()
        var added = [String]()
        var removed = [String]()

        for old in oldAssigness {
            if !newAssignees.contains(old) {
                removed.append(old)
                newEvents.append(IssueRequestModel(
                    id: UUID().uuidString,
                    actor: actor,
                    user: old,
                    date: Date(),
                    event: .unassigned,
                    width: 0 // will be inflated when asked
                    ))
            }
        }
        for new in newAssignees {
            if !oldAssigness.contains(new) {
                added.append(new)
                newEvents.append(IssueRequestModel(
                    id: UUID().uuidString,
                    actor: actor,
                    user: new,
                    date: Date(),
                    event: .assigned,
                    width: 0 // will be inflated when asked
                ))
            }
        }

        let optimistic = previous.updated(
            assignee: IssueAssigneesModel(users: assignees, type: .assigned),
            timelinePages: previous.timelinePages(appending: newEvents)
        )

        let cache = self.cache
        cache.set(value: optimistic)

        let path = "repos/\(owner)/\(repo)/issues/\(number)/assignees"

        let handler: (Int, Int?) -> Void = { (expect, status) in
            if status != expect {
                cache.set(value: previous)
                ToastManager.showGenericError()
            }
        }

        // https://developer.github.com/v3/issues/assignees/#add-assignees-to-an-issue
        if added.count > 0 {
            request(GithubClient.Request(
                path: path,
                method: .post,
                parameters: ["assignees": added]
            ) { (response, _) in
                handler(201, response.response?.statusCode)
            })
        }

        // https://developer.github.com/v3/issues/assignees/#remove-assignees-from-an-issue
        if removed.count > 0 {
            request(GithubClient.Request(
                path: path,
                method: .delete,
                parameters: ["assignees": removed]
            ) { (response, _) in
                handler(200, response.response?.statusCode)
            })
        }
    }

}
