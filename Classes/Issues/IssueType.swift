//
//  IssueType.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import UIKit

protocol IssueType {
    var id: String { get }
    var pullRequest: Bool { get }
    var number: Int { get }
    var title: String { get }
    var labelableFields: LabelableFields { get }
    var commentFields: CommentFields { get }
    var reactionFields: ReactionFields { get }
    var closableFields: ClosableFields { get }
    var merged: Bool { get }
    var locked: Bool { get }

    func timelineViewModels(width: CGFloat) -> [ListDiffable]
}
