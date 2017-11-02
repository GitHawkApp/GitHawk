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

                    let milestoneModel: IssueMilestoneModel?
                    if let milestone = issueType.milestoneFields {
                        milestoneModel = IssueMilestoneModel(number: milestone.number, title: milestone.title)
                    } else {
                        milestoneModel = nil
                    }

                    let canAdmin = repository?.viewerCanAdminister ?? false

                    let issueResult = IssueResult(
                        id: issueType.id,
                        pullRequest: issueType.pullRequest,
                        status: IssueStatusModel(status: status, pullRequest: issueType.pullRequest, locked: issueType.locked),
                        title: titleStringSizing(title: issueType.title, width: width),
                        labels: IssueLabelsModel(viewerCanUpdate: issueType.viewerCanUpdate, labels: issueType.labelableFields.issueLabelModels),
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

        request(Request(
            path: "repos/\(owner)/\(repo)/issues/\(number)",
            method: .patch,
            parameters: [ "state": newStatus.status.rawValue ],
            completion: { (response, _) in
                if response.value == nil {
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

    func fetchPRComments(previous: IssueResult, owner: String, repo: String, number: Int, width: CGFloat) {
        // no point requesting since only issues can have PR comments
        guard previous.pullRequest else { return }

        let viewerUsername = userSession?.username
        let cache = self.cache

        request(Request(
            path: "repos/\(owner)/\(repo)/pulls/\(number)/comments",
            headers: ["Accept": "application/vnd.github.squirrel-girl-preview"],
            completion: { (response, _) in

                guard let jsonArr = response.value as? [ [String: Any] ] else {
                    ToastManager.showGenericError()
                    return
                }

                struct Thread {
                    let hunk: IssueDiffHunkModel
                    var comments = [ListDiffable]()
                }

                var threadIDs = [Int]()
                var threads = [Int: Thread]()

                for json in jsonArr {
                    guard let id = json["id"] as? Int,
                    let comment = createReviewComment(id: "\(id)", owner: owner, repo: repo, viewer: viewerUsername, json: json, width: width)
                        else { continue }

                    if let replyID = json["in_reply_to_id"] as? Int {
                        // this should exist since the root will always be posted before the reply
                        // payload is delivered sorted by creation date descending
                        threads[replyID]?.comments.append(comment)
                    } else {
                        guard let diffHunk = json["diff_hunk"] as? String,
                        let path = json["path"] as? String
                            else { continue }

                        let code = CreateDiffString(code: diffHunk, limit: true)
                        let text = NSAttributedStringSizing(containerWidth: 0, attributedText: code, inset: IssueDiffHunkPreviewCell.textViewInset)

                        threads[id] = Thread(
                            hunk: IssueDiffHunkModel(path: path, preview: text),
                            comments: [comment]
                        )

                        // create diff hunk and root comment
                        // append to threads and threadIDs
                        threadIDs.append(id)
                    }
                }

                if let latest = cache.get(id: previous.id) as IssueResult? {
                    var models = [ListDiffable]()
                    for id in threadIDs {
                        guard let thread = threads[id] else { continue }
                        models.append(thread.hunk)
                        models += thread.comments
                    }
                    cache.set(value: latest.updated(timelinePages: latest.timelinePages(appending: models)))
                }
        }))
    }

}

private func createReviewComment(
    id: String,
    owner: String,
    repo: String,
    viewer: String?,
    json: [String: Any],
    width: CGFloat
    ) -> IssueCommentModel? {
    guard let reactionJSON = json["reactions"] as? [String: Any],
        let userJSON = json["user"] as? [String: Any],
        let userAvatar = userJSON["avatar_url"] as? String,
        let userAvatarURL = URL(string: userAvatar),
        let createdString = json["created_at"] as? String,
        let created = GithubAPIDateFormatter().date(from: createdString),
        let login = userJSON["login"] as? String
        else { return nil }

    let body = json["body"] as? String ?? ""

    var reactionModels = [ReactionViewModel]()
    if let count = reactionJSON["+1"] as? Int, count > 0 {
        reactionModels.append(ReactionViewModel(
            content: .thumbsUp,
            count: count,
            viewerDidReact: false,
            users: []
        ))
    }
    if let count = reactionJSON["-1"] as? Int, count > 0 {
        reactionModels.append(ReactionViewModel(
            content: .thumbsDown,
            count: count,
            viewerDidReact: false,
            users: []
        ))
    }
    if let count = reactionJSON["confused"] as? Int, count > 0 {
        reactionModels.append(ReactionViewModel(
            content: .confused,
            count: count,
            viewerDidReact: false,
            users: []
        ))
    }
    if let count = reactionJSON["heart"] as? Int, count > 0 {
        reactionModels.append(ReactionViewModel(
            content: .heart,
            count: count,
            viewerDidReact: false,
            users: []
        ))
    }
    if let count = reactionJSON["hooray"] as? Int, count > 0 {
        reactionModels.append(ReactionViewModel(
            content: .hooray,
            count: count,
            viewerDidReact: false,
            users: []
        ))
    }
    if let count = reactionJSON["laugh"] as? Int, count > 0 {
        reactionModels.append(ReactionViewModel(
            content: .laugh,
            count: count,
            viewerDidReact: false,
            users: []
        ))
    }

    let details = IssueCommentDetailsViewModel(
        date: created,
        login: login,
        avatarURL: userAvatarURL,
        didAuthor: login == viewer,
        editedBy: nil,
        editedAt: nil
    )

    let reactions = IssueCommentReactionViewModel(models: reactionModels)
    let options = commentModelOptions(owner: owner, repo: repo)
    let bodies = CreateCommentModels(markdown: body, width: width, options: options)
    let collapse = IssueCollapsedBodies(bodies: bodies, width: width)

    return IssueCommentModel(
        id: id,
        details: details,
        bodyModels: bodies,
        reactions: reactions,
        collapse: collapse,
        threadState: .neck,
        rawMarkdown: body,
        viewerCanUpdate: false,
        viewerCanDelete: false,
        isRoot: false
    )
}
