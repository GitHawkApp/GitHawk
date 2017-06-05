//
//  IssueType.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

protocol IssueType {
    var pullRequest: Bool { get }
    var number: Int { get }
    var title: String { get }
    var labelableFields: LabelableFields { get }
    var commentFields: CommentFields { get }
    var reactionFields: ReactionFields { get }
    var closableFields: ClosableFields { get }
}
