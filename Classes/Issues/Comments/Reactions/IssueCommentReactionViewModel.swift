//
//  IssueCommentReactionViewModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/1/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

extension ReactionContent: Hashable {
    public var hashValue: Int {
        return rawValue.hashValue
    }
}

final class IssueCommentReactionViewModel: ListDiffable {

    static let allReactions: [ReactionContent] = [
        .thumbsUp,
        .thumbsDown,
        .laugh,
        .hooray,
        .confused,
        .heart,
        .rocket,
        .eyes
    ]

    let models: [ReactionViewModel]
    private let map: [ReactionContent: ReactionViewModel]
    private let flatState: String

    init(models: [ReactionViewModel]) {
        let reactions = IssueCommentReactionViewModel.allReactions
        let sortedModels = models.sorted { (m1, m2) -> Bool in
            let m1Idx = reactions.firstIndex(of: m1.content) ?? 0
            let m2Idx = reactions.firstIndex(of: m2.content) ?? 0
            return m1Idx < m2Idx
        }
        self.models = sortedModels

        var map = [ReactionContent: ReactionViewModel]()
        var flatState = ""
        for model in sortedModels {
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
