//
//  IssueEvent.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

enum IssueEvent: String {

    // https://developer.github.com/v3/issues/events/#events-1
    case closed = "closed"
    case reopened = "reopened"
    case subscribed = "subscribed"
    case merged = "merged"
    case referenced = "referenced"
    case mentioned = "mentioned"
    case assigned = "assigned"
    case unassigned = "unassigned"
    case labeled = "labeled"
    case unlabeled = "unlabeled"
    case milestoned = "milestoned"
    case demilestoned = "demilestoned"
    case renamed = "renamed"
    case locked = "locked"
    case unlocked = "unlocked"
    case head_ref_deleted = "head_ref_deleted"
    case head_ref_restored = "head_ref_restored"
    case review_dismissed = "review_dismissed"
    case review_requested = "review_requested"
    case review_request_removed = "review_request_removed"
    case added_to_project = "added_to_project"
    case moved_columns_in_project = "moved_columns_in_project"
    case removed_from_project = "removed_from_project"
    case converted_note_to_issue = "converted_note_to_issue"

}
