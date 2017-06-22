//
//  IssueCommentHtmlModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentHtmlModel: NSObject, IGListDiffable {

    let html: String

    init(html: String) {
        self.html = html
    }

    // MARK: IGListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return html as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        return true
    }

}
