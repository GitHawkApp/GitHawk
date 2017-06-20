//
//  IssueCommentHrModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentHrModel: NSObject, IGListDiffable {

    // MARK: IGListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        return true
    }

}
