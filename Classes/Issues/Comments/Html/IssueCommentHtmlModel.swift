//
//  IssueCommentHtmlModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentHtmlModel: NSObject, ListDiffable, ListSwiftDiffable {

    let html: String
    let baseURL: URL?

    init(html: String, baseURL: URL? = nil) {
        self.html = html
        self.baseURL = baseURL
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return html as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

    // MARK: ListSwiftDiffable

    var identifier: String {
        return html
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        return true
    }

}
