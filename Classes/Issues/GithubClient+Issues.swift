//
//  GithubClient+Issues.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import GitHubAPI

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
                        milestoneModel = Milestone(
                            number: milestone.number,
                            title: milestone.title,
                            dueOn: milestone.dueOn?.githubDate,
                            openIssueCount: milestone.openCount.totalCount,
                            totalIssueCount: milestone.totalCount.totalCount
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
                        fileChanges: issueType.fileChanges,
                        mergeModel: issueType.mergeModel
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

        let handler: (GitHubAPI.Result<ReactionFields>) -> Void = { result in
            switch result {
            case .success(let data):
                completion(createIssueReactions(reactions: data))
            case .failure:
                completion(nil)
                ToastManager.showGenericError()
            }
        }

        if isAdd {
            client.mutate(AddReactionMutation(subject_id: subjectID, content: content), result: { data in
                data.addReaction?.subject.fragments.reactionFields
            }, completion: handler)
        } else {
            client.mutate(RemoveReactionMutation(subject_id: subjectID, content: content), result: { data in
                data.removeReaction?.subject.fragments.reactionFields
            }, completion: handler)
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

        client.send(V3SetIssueStatusRequest(owner: owner, repo: repo, number: number, state: stateString)) { result in
            switch result {
            case .success: break
            case .failure:
                cache.set(value: previous)
                ToastManager.showGenericError()
            }
        }
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

        client.send(V3LockIssueRequest(owner: owner, repo: repo, number: "\(number)", locked: locked)) { result in
            switch result {
            case .success:
                completion?(.success(true))
            case .failure:
                cache.set(value: previous)
                ToastManager.showGenericError()
                completion?(.error(nil))
            }
        }
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
        completion: @escaping (Result<V3Permission.Permission>) -> Void
        ) {
        guard let viewer = userSession?.username else {
            completion(.error(nil))
            return
        }

        client.send(V3ViewerIsCollaboratorRequest(owner: owner, repo: repo, viewer: viewer)) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.error(error))
            }
        }
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

        client.send(V3SetRepositoryLabelsRequest(
            owner: owner,
            repo: repo,
            number: number,
            labels: labels.map { $0.name })
        ) { result in
            switch result {
            case .success: break
            case .failure:
                cache.set(value: previous)
                ToastManager.showGenericError()
            }
        }
    }

    func addPeople(
        type: V3AddPeopleRequest.PeopleType,
        previous: IssueResult,
        owner: String,
        repo: String,
        number: Int,
        people: [IssueAssigneeViewModel]
        ) {
        guard let actor = userSession?.username else { return }

        let addedType: IssueRequestModel.Event
        let removedType: IssueRequestModel.Event
        let oldAssigness: Set<String>
        switch type {
        case .assignees:
            addedType = .assigned
            removedType = .unassigned
            oldAssigness = Set<String>(previous.assignee.users.map { $0.login })
        case .reviewers:
            addedType = .reviewRequested
            removedType = .reviewRequestRemoved
            oldAssigness = Set<String>(previous.reviewers?.users.map { $0.login } ?? [])
        }

        let newAssignees = Set<String>(people.map { $0.login })

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
                    event: removedType,
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
                    event: addedType,
                    width: 0 // will be inflated when asked
                ))
            }
        }

        let timelinePages = previous.timelinePages(appending: newEvents)
        let optimistic: IssueResult
        switch type {
        case .assignees:
            optimistic = previous.updated(
                assignee: IssueAssigneesModel(users: people, type: .assigned),
                timelinePages: timelinePages
            )
        case .reviewers:
            optimistic = previous.withReviewers(
                IssueAssigneesModel(users: people, type: .reviewRequested),
                timelinePages: timelinePages
            )
        }

        let cache = self.cache
        cache.set(value: optimistic)

        // https://developer.github.com/v3/issues/assignees/#add-assignees-to-an-issue
        // https://developer.github.com/v3/pulls/review_requests/#create-a-review-request
        if added.count > 0 {
            client.send(V3AddPeopleRequest(
                owner: owner,
                repo: repo,
                number: number,
                type: type,
                add: true,
                people: added)
            ) { result in
                switch result {
                case .success: break
                case .failure:
                    cache.set(value: previous)
                    ToastManager.showGenericError()
                }
            }
        }

        // https://developer.github.com/v3/issues/assignees/#remove-assignees-from-an-issue
        // https://developer.github.com/v3/pulls/review_requests/#delete-a-review-request
        if removed.count > 0 {
            client.send(V3AddPeopleRequest(
                owner: owner,
                repo: repo,
                number: number,
                type: type,
                add: false,
                people: added)
            ) { result in
                switch result {
                case .success: break
                case .failure:
                    cache.set(value: previous)
                    ToastManager.showGenericError()
                }
            }
        }
    }

}
