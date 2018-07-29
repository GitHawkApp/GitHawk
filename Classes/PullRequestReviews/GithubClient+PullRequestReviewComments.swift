//
//  GithubClient+PullRequestReviewComments.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import GitHubAPI
import StyledTextKit
import Squawk

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
        completion: @escaping (Result<[ListDiffable]>) -> ()
        ) {
        let viewerUsername = userSession?.username
        let contentSizeCategory = UIApplication.shared.preferredContentSizeCategory

        client.send(V3PullRequestCommentsRequest(owner: owner, repo: repo, number: number)) { result in
            switch result {
            case .failure(let error):
                Squawk.showGenericError()
                completion(.error(error))
            case .success(let response):
                struct Thread {
                    let hunk: String
                    let path: String
                    var comments = [ReviewComment]()
                }

                DispatchQueue.global().async {
                    var threadIDs = [Int]()
                    var threads = [Int: Thread]()

                    for json in response.data {
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
                        let text = StyledTextRenderer(
                            string: code,
                            contentSizeCategory: contentSizeCategory,
                            inset: IssueDiffHunkPreviewCell.textViewInset
                        )
                        models.append(IssueDiffHunkModel(path: thread.path, preview: text, offset: models.count))

                        for comment in thread.comments {
                            models.append(createReviewComment(
                                owner: owner,
                                repo: repo,
                                model: comment,
                                viewer: viewerUsername,
                                contentSizeCategory: contentSizeCategory,
                                width: width
                            ))
                        }

                        models.append(PullRequestReviewReplyModel(replyID: id))
                    }

                    DispatchQueue.main.async {
                        completion(.success(models))
                    }
                }
            }
        }
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
        let contentSizeCategory = UIApplication.shared.preferredContentSizeCategory

        client.send(V3SendPullRequestCommentRequest(
            owner: owner,
            repo: repo,
            number: number,
            body: body,
            inReplyTo: inReplyTo)
        ) { result in
            switch result {
            case .success(let response):
                if let model = createReviewCommentModel(id: response.id, json: response.data) {
                    let comment = createReviewComment(
                        owner: owner,
                        repo: repo,
                        model: model,
                        viewer: viewer,
                        contentSizeCategory: contentSizeCategory,
                        width: width
                    )
                    completion(.success(comment))
                } else {
                    Squawk.showGenericError()
                    completion(.error(nil))
                }
            case .failure(let error):
                Squawk.showGenericError()
                completion(.error(error))
            }
        }
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
    contentSizeCategory: UIContentSizeCategory,
    width: CGFloat
    ) -> IssueCommentModel {
    let checkedMarkdown = CheckIfSentWithGitHawk(markdown: model.body)

    let details = IssueCommentDetailsViewModel(
        date: model.created,
        login: model.author,
        avatarURL: model.authorAvatarURL,
        didAuthor: model.author == viewer,
        editedBy: nil,
        editedAt: nil,
        sentWithGitHawk: checkedMarkdown.sentWithGitHawk
    )

    let reactions = IssueCommentReactionViewModel(models: [])
    let bodies = MarkdownModels(
        checkedMarkdown.markdown,
        owner: owner,
        repo: repo,
        width: width,
        viewerCanUpdate: false,
        contentSizeCategory: contentSizeCategory,
        isRoot: false
    )

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
