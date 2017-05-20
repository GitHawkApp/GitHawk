//
//  IssueLabelsModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueLabelsModel: IGListDiffable {

    let labels: [Label]

    init(labels: [Label]) {
        self.labels = labels
    }

    func diffIdentifier() -> NSObjectProtocol {
        // hardcoded b/c one per list
        return "labels" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        return true
    }

}

//extension IssueLabelsModel: IGListDiffable {
//
//    func diffIdentifier() -> NSObjectProtocol {
//        // hardcoded b/c one per list
//        return "labels" as NSObjectProtocol
//    }
//
//    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
//        return true
//    }
//
//}
