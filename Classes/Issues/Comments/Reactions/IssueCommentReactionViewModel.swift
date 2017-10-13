//
//  IssueCommentReactionViewModel.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 6/1/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentReactionViewModel: ListDiffable {

    let models: [ReactionViewModel]
    private let map: [String: Int]

    init(models: [ReactionViewModel]) {
        self.models = models

        var map = [String: Int]()
        for model in models {
            map[model.content.rawValue] = model.count
        }
        self.map = map
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        // assume only one model per usage
        return "reactions" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueCommentReactionViewModel else { return false }
        return map == object.map
    }

}
