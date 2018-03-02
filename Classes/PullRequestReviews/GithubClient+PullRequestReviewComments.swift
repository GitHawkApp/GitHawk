//
//  GithubClient+PullRequestReviewComments.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

extension GithubClient {

    fileprivate struct ReviewComment {
        let id: Int
        let body: String
        let created: Date
        let author: String
        let authorAvatarURL: URL
    }

    func fetchPRComments(
        owner: String,
        repo: String,
        number: Int,
        width: CGFloat,
        completion: @escaping (Result<([ListDiffable], Int?)>) -> ()
        ) {
        let viewerUsername = userSession?.username
        request(Request(
            client: userSession?.client,
            path: "repos/\(owner)/\(repo)/pulls/\(number)/comments",
            completion: { (response, nextPage) in

                guard let jsonArr = response.value as? [ [String: Any] ] else {
                    ToastManager.showGenericError()
                    completion(.error(response.error))
                    return
                }

                struct Thread {
                    let hunk: String
                    let path: String
                    var comments = [ReviewComment]()
                }

                DispatchQueue.global().async {
                    var threadIDs = [Int]()
                    var threads = [Int: Thread]()

                    for json in jsonArr {
                        guard let id = json["id"] as? Int,
                            let reviewComment = createReviewCommentModel(id: id, json: json)
                            else { continue }

                        if let replyID = json["in_reply_to_id"] as? Int {
                            // this should exist since the root will always be posted before the reply
                            // payload is delivered sorted by creation date descending
                            threads[replyID]?.comments.append(reviewComment)
                        } else {
                            guard let diffHunk = json["diff_hunk"] as? String,
                                let path = json["path"] as? String
                                else { continue }

                            threads[id] = Thread(
                                hunk: diffHunk,
                                path: path,
                                comments: [reviewComment]
                            )

                            // create diff hunk and root comment
                            // append to threads and threadIDs
                            threadIDs.append(id)
                        }
                    }

                    var models = [ListDiffable]()
                    for id in threadIDs {
                        guard let thread = threads[id] else { continue }

                        let code = CreateDiffString(code: thread.hunk, limit: true)
                        let text = NSAttributedStringSizing(
                            containerWidth: 0,
                            attributedText: code,
                            inset: IssueDiffHunkPreviewCell.textViewInset
                        )
                        models.append(IssueDiffHunkModel(path: thread.path, preview: text, offset: models.count))

                        for comment in thread.comments {
                            models.append(createReviewComment(
                                owner: owner,
                                repo: repo,
                                model: comment,
                                viewer: viewerUsername,
                                width: width
                            ))
                        }

                        models.append(PullRequestReviewReplyModel(replyID: id))
                    }

                    DispatchQueue.main.async {
                        completion(.success((models, nextPage?.next)))
                    }
                }
        }))
    }

    func sendComment(
        body: String,
        inReplyTo: Int,
        owner: String,
        repo: String,
        number: Int,
        width: CGFloat,
        completion: @escaping (Result<IssueCommentModel>) -> ()
        ) {
        let viewer = userSession?.username

        // https://developer.github.com/v3/pulls/comments/#alternative-input
        request(Request(
            client: userSession?.client,
            path: "repos/\(owner)/\(repo)/pulls/\(number)/comments",
            method: .post,
            parameters: ["body": body, "in_reply_to": inReplyTo],
            completion: { (response, _) in
                if response.response?.statusCode == 201,
                    let json = response.value as? [String: Any],
                    let id = json["id"] as? Int,
                    let model = createReviewCommentModel(id: id, json: json) {
                    let comment = createReviewComment(
                        owner: owner,
                        repo: repo,
                        model: model,
                        viewer: viewer,
                        width: width
                    )
                    completion(.success(comment))
                } else {
                    ToastManager.showGenericError()
                    completion(.error(response.error))
                }
        }))
    }

}

private func createReviewCommentModel(id: Int, json: [String: Any]) -> GithubClient.ReviewComment? {
    guard let userJSON = json["user"] as? [String: Any],
        let userAvatar = userJSON["avatar_url"] as? String,
        let userAvatarURL = URL(string: userAvatar),
        let createdString = json["created_at"] as? String,
        let created = createdString.githubDate,
        let login = userJSON["login"] as? String
        else { return nil }
    return GithubClient.ReviewComment(
        id: id,
        body: json["body"] as? String ?? "",
        created: created,
        author: login,
        authorAvatarURL: userAvatarURL
    )
}

private func createReviewComment(
    owner: String,
    repo: String,
    model: GithubClient.ReviewComment,
    viewer: String?,
    width: CGFloat
    ) -> IssueCommentModel {
    let details = IssueCommentDetailsViewModel(
        date: model.created,
        login: model.author,
        avatarURL: model.authorAvatarURL,
        didAuthor: model.author == viewer,
        editedBy: nil,
        editedAt: nil
    )

    let reactions = IssueCommentReactionViewModel(models: [])
    let options = commentModelOptions(owner: owner, repo: repo)
    let bodies = CreateCommentModels(markdown: model.body, width: width, options: options)

    return IssueCommentModel(
        id: "\(model.id)",
        details: details,
        bodyModels: bodies,
        reactions: reactions,
        collapse: nil,
        threadState: .neck,
        rawMarkdown: model.body,
        viewerCanUpdate: false,
        viewerCanDelete: false,
        isRoot: false,
        number: model.id,
        asReviewComment: true
    )
}
