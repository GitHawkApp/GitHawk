//
//  IssueLocalReaction.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

enum IssueReactionOperation {
    case add
    case subtract
    case insert
    case remove
    case none
}

struct IssueLocalReactionModel {
    let viewModel: IssueCommentReactionViewModel
    let operation: IssueReactionOperation
}

func IssueLocalReaction(
    fromServer: IssueCommentReactionViewModel,
    previousLocal: IssueCommentReactionViewModel?,
    content: ReactionContent,
    add: Bool
    ) -> IssueLocalReactionModel {
    let base = previousLocal ?? fromServer

    // capture exactly what type of transition is taking place:
    // inserting the first reaction (count == 1)
    // incrementing a reaction (count > 1)
    // removing the last reaction (count == 1)
    // decrementing a reaction (count > 1)
    let operation: IssueReactionOperation

    var prev: (index: Int, model: ReactionViewModel)? = nil
    for (i, model) in base.models.enumerated() {
        if model.content == content {
            prev = (i, model)
            break
        }
    }

    var models = base.models
    if let foundPrev = prev {
        let newCount = foundPrev.model.count + (add ? 1 : -1)
        if newCount == 0 {
            models.remove(at: foundPrev.index)
            operation = .remove
        } else {
            let model = ReactionViewModel(
                content: content,
                count: newCount,
                viewerDidReact: add,
                users: foundPrev.model.users
            )
            models[foundPrev.index] = model
            // found a previous, op isn't last/first but must match add param
            operation = add ? .add : .subtract
        }
    } else if add {
        models.append(ReactionViewModel(
            content: content,
            count: 1,
            viewerDidReact: true,
            users: []
        ))
        operation = .insert
    } else {
        operation = .none
    }
    return IssueLocalReactionModel(
        viewModel: IssueCommentReactionViewModel(models: models),
        operation: operation
    )
}
