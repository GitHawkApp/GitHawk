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
        let gutter = Styles.Sizes.commentGutter
        let rowSpacing = Styles.Sizes.rowSpacing

        switch threadState {
        case .single:
            // title and other header objects will have bottom insetting
            if isRoot {
                return UIEdgeInsets(
                    top: 0,
                    left: gutter,
                    bottom: rowSpacing,
                    right: gutter
                )
            } else {
                return UIEdgeInsets(
                    top: rowSpacing,
                    left: gutter,
                    bottom: rowSpacing,
                    right: gutter
                )
            }
        case .neck:
            return UIEdgeInsets(
                top: 0,
                left: gutter,
                bottom: 0,
                right: gutter
            )
        case .tail:
            return UIEdgeInsets(
                top: 0,
                left: gutter,
                bottom: rowSpacing,
                right: gutter
            )
        }
    }

}
