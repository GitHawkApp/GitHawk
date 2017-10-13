//
//  IssueCommentReactionViewModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/1/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentReactionViewModel: ListDiffable {

    let models: [ReactionViewModel]
    private let map: [ReactionContent: ReactionViewModel]
    private let flatState: String

    init(models: [ReactionViewModel]) {
        self.models = models

        var map = [ReactionContent: ReactionViewModel]()
        var flatState = ""
        for model in models {
            map[model.content] = model
            flatState += "\(model.content.rawValue)\(model.count)"
        }
        self.map = map
        self.flatState = flatState
    }

    // MARK: Public API

    func viewerDidReact(reaction: ReactionContent) -> Bool {
        return map[reaction]?.viewerDidReact == true
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        // assume only one model per usage
        return "reactions" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueCommentReactionViewModel else { return false }
        return flatState == object.flatState
    }

}
