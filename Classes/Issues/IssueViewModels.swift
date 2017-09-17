//
//  IssueViewModels.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

func titleStringSizing(title: String, width: CGFloat) -> NSAttributedStringSizing {
    let attributedString = NSAttributedString(
        string: title,
        attributes: [
            NSFontAttributeName: Styles.Fonts.headline,
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color
        ])
    return NSAttributedStringSizing(
        containerWidth: width,
        attributedText: attributedString,
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
    width: CGFloat,
    owner: String,
    repo: String,
    threadState: IssueCommentModel.ThreadState
    ) -> IssueCommentModel? {
    guard let author = commentFields.author,
        let date = GithubAPIDateFormatter().date(from: commentFields.createdAt),
        let avatarURL = URL(string: author.avatarUrl)
        else { return nil }

    let editedAt: Date? = {
        guard let editedDate = commentFields.lastEditedAt else { return nil }
        return GithubAPIDateFormatter().date(from: editedDate)
    }()
    
    let details = IssueCommentDetailsViewModel(
        date: date,
        login: author.login,
        avatarURL: avatarURL,
        didAuthor: commentFields.viewerDidAuthor,
        editedBy: commentFields.editor?.login,
        editedAt: editedAt
    )

    let options = GitHubMarkdownOptions(owner: owner, repo: repo, flavors: [.issueShorthand, .usernames])
    let bodies = CreateCommentModels(markdown: commentFields.body, width: width, options: options)
    let reactions = createIssueReactions(reactions: reactionFields)
    let collapse = IssueCollapsedBodies(bodies: bodies, width: width)
    return IssueCommentModel(
        id: id,
        details: details,
        bodyModels: bodies,
        reactions: reactions,
        collapse: collapse,
        threadState: threadState
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
