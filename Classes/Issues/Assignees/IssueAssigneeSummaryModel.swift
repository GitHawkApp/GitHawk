//
//  IssueAssigneeSummaryModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueAssigneeSummaryModel: ListDiffable {

    let title: String
    let urls: [URL]
    let expanded: Bool
    private let urlHash: String

    init(title: String, urls: [URL], expanded: Bool) {
        self.title = title
        self.urls = urls
        self.expanded = expanded
        self.urlHash = urls.reduce("") { $0 + $1.path }
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return title as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueAssigneeSummaryModel else { return false }
        return expanded == object.expanded
        && urlHash == object.urlHash
    }

}
