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

    enum State: Int, CustomStringConvertible {
        case success
        case pending
        case failure
        case warning

        var description: String {
            switch self {
            case .success:
                return NSLocalizedString("success", comment: "The merge status' success state")
            case .pending:
                return NSLocalizedString("pending", comment: "The merge status' pending state")
            case .failure:
                return NSLocalizedString("failure", comment: "The merge status' failure state")
            case .warning:
                return NSLocalizedString("warning", comment: "The merge status' warning state")
            }
        }
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
