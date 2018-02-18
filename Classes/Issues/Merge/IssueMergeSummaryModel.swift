//
//  IssueMergeSummaryModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 2/11/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueMergeSummaryModel: ListDiffable {

    enum State: Int {
        case success
        case pending
        case failure
        case warning
    }

    let title: String
    let state: State

    init(title: String, state: State) {
        self.title = title
        self.state = state
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return title as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueMergeSummaryModel else { return false }
        return state == object.state
    }

}
