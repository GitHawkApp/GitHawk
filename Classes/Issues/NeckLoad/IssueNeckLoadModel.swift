//
//  IssueNeckLoadModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/27/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueNeckLoadModel: NSObject, ListDiffable {

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
