//
//  IssueViewModels.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import StyledTextKit

func titleStringSizing(
    title: String,
    contentSizeCategory: UIContentSizeCategory,
    width: CGFloat
    ) -> StyledTextRenderer {
    let builder = StyledTextBuilder(styledText: StyledText(
        text: title, style: Styles.Text.headline.with(foreground: Styles.Colors.Gray.dark.color)
    ))
    return StyledTextRenderer(
        string: builder.build(),
        contentSizeCategory: contentSizeCategory,
        inset: IssueTitleCell.inset
    )
}

func createIssueReactions(reactions: ReactionFields) -> IssueCommentReactionViewModel {
    var models = [ReactionViewModel]()

    for group in reactions.reactionGroups ?? [] {
        // do not display reactions for 0 count
        let count = group.users.totalCount
        guard count > 0 else { continue }

        let nodes: [String] = {
            guard let filtered = group.users.nodes?.filter({ $0?.login != nil }) as? [ReactionFields.ReactionGroup.User.Node] else {
                return []
            }

            return filtered.map({ $0.login })
        }()

        models.append(ReactionViewModel(content: group.content, count: count, viewerDidReact: group.viewerHasReacted, users: nodes))
    }

    return IssueCommentReactionViewModel(models: models)
}

func createCommentModel(
    id: String,
    commentFields: CommentFields,
    reactionFields: ReactionFields,
    contentSizeCategory: UIContentSizeCategory,
    width: CGFloat,
    owner: String,
    repo: String,
    threadState: IssueCommentModel.ThreadState,
    viewerCanUpdate: Bool,
    viewerCanDelete: Bool,
    isRoot: Bool
    ) -> IssueCommentModel? {
    guard let author = commentFields.author,
        let date = commentFields.createdAt.githubDate,
        let avatarURL = URL(string: author.avatarUrl)
        else { return nil }

    let checkedMarkdown = CheckIfSentWithGitHawk(markdown: commentFields.body)

    let details = IssueCommentDetailsViewModel(
        date: date,
        login: author.login,
        avatarURL: avatarURL,
        didAuthor: commentFields.viewerDidAuthor,
        editedBy: commentFields.editor?.login,
        editedAt: commentFields.lastEditedAt?.githubDate,
        sentWithGitHawk: checkedMarkdown.sentWithGitHawk
    )

    let bodies = MarkdownModels(
        checkedMarkdown.markdown,
        owner: owner,
        repo: repo,
        width: width,
        viewerCanUpdate: viewerCanUpdate,
        contentSizeCategory: contentSizeCategory,
        isRoot: isRoot
    )
    let reactions = createIssueReactions(reactions: reactionFields)
    let collapse = IssueCollapsedBodies(bodies: bodies, width: width)
    return IssueCommentModel(
        id: id,
        details: details,
        bodyModels: bodies,
        reactions: reactions,
        collapse: collapse,
        threadState: threadState,
        rawMarkdown: commentFields.body,
        viewerCanUpdate: viewerCanUpdate,
        viewerCanDelete: viewerCanDelete,
        isRoot: isRoot,
        number: GraphQLIDDecode(id: id, separator: "IssueComment")
    )
}

func createAssigneeModel(assigneeFields: AssigneeFields) -> IssueAssigneesModel {
    var models = [IssueAssigneeViewModel]()
    for node in assigneeFields.assignees.nodes ?? [] {
        guard let node = node,
            let url = URL(string: node.avatarUrl)
            else { continue }
        models.append(IssueAssigneeViewModel(login: node.login, avatarURL: url))
    }
    return IssueAssigneesModel(users: models, type: .assigned)
}
