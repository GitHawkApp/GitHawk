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
        switch threadState {
        case .single:
            // title and other header objects will have bottom insetting
            if isRoot {
                return UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
            } else {
                return .zero
            }
        case .neck:
            return .zero
        case .tail:
            return .zero
        }
    }

}
