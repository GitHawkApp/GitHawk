//
//  IssueCommentModel+Inset.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/30/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension IssueCommentModel {

    var commentSectionControllerInset: UIEdgeInsets {
        let rowSpacing = Styles.Sizes.rowSpacing

        switch threadState {
        case .single:
            // title and other header objects will have bottom insetting
            if isRoot {
                return Styles.Sizes.issueInset(top: 12, bottom: rowSpacing, sides: 0)
            } else {
                return Styles.Sizes.issueInset(vertical: rowSpacing)
            }
        case .neck:
            return Styles.Sizes.issueInset(vertical: 0)
        case .tail:
            return Styles.Sizes.issueInset(top: 0, bottom: rowSpacing)
        }
    }

}
