//
//  IssueSummaryType.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

protocol IssueSummaryType {
    
    var id: String { get }
    var attributedTitle: NSAttributedStringSizing { get }
    var number: Int { get }
    var createdAtDate: Date? { get }
    var rawState: String { get }
    var authorName: String? { get }
    var isIssue: Bool { get }
    
}

class IssueSummaryModel: ListDiffable {
    let info: IssueSummaryType
    
    init(info: IssueSummaryType) {
        self.info = info
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return info.id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueSummaryModel else { return false }
        return info.id == object.info.id &&
               info.attributedTitle == object.info.attributedTitle &&
               info.number == object.info.number &&
               info.rawState == object.info.rawState
    }
}
