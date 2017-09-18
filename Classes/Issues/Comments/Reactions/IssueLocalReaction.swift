//
//  IssueLocalReaction.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func IssueLocalReaction(
    fromServer: IssueCommentReactionViewModel,
    previousLocal: IssueCommentReactionViewModel?,
    content: ReactionContent,
    add: Bool
    ) -> IssueCommentReactionViewModel {
    let base = previousLocal ?? fromServer

    // update model
    // insert when from 0 && isAdd
    // delete when 1 && !isAdd

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
        } else {
            models[foundPrev.index] = ReactionViewModel(
                content: content,
                count: newCount,
                viewerDidReact: add,
                users: foundPrev.model.users
            )
        }
    } else if add {
        models.append(ReactionViewModel(
            content: content,
            count: 1,
            viewerDidReact: true,
            users: []
        ))
    }
    return IssueCommentReactionViewModel(models: models)
}
