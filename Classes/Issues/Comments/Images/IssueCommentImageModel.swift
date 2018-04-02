//
//  IssueCommentImageModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/21/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentImageModel: ListDiffable {

    let url: URL
    let title: String?

    init(url: URL, title: String?) {
        self.url = url
        self.title = title
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return "\(url.absoluteString)\(title ?? "")" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        // lazy, assuming anything matching this url as the diffidentifier is the same object
        return true
    }

}
