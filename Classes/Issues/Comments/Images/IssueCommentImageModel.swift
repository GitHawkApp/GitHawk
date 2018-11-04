//
//  IssueCommentImageModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/21/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentImageModel: ListDiffable, ListSwiftDiffable {

    let url: URL
    let title: String?
    private let _identifier: String

    init(url: URL, title: String?) {
        self.url = url
        self.title = title
        self._identifier = "\(url.absoluteString)\(title ?? "")"
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return _identifier as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        // lazy, assuming anything matching this url as the diffidentifier is the same object
        return true
    }

    // MARK: ListSwiftDiffable

    var identifier: String {
        return _identifier
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        // lazy, assuming anything matching this url as the diffidentifier is the same object
        return true
    }

}
