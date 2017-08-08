//
//  IssueSummaryType.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

protocol IssueSummaryType {
    
    var id: String { get }
    var attributedTitle: NSAttributedStringSizing { get }
    var number: Int { get }
    var createdAtDate: Date? { get }
    var rawState: String { get }
    var authorName: String? { get }
    var isIssue: Bool { get }
    
}

extension IssueSummaryType {
    var stateIcon: UIImage? {
        var name: String
        
        switch rawState {
        case IssueState.open.rawValue where isIssue: name = "issue-opened"
        case IssueState.closed.rawValue where isIssue: name = "issue-closed"
        case PullRequestState.open.rawValue where !isIssue: name = "git-pull-request"
        case PullRequestState.closed.rawValue where !isIssue: name = "git-pull-request"
        case PullRequestState.merged.rawValue where !isIssue: name = "git-merge"
        default: return nil
        }
        
        return UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
    }
    
    var stateColor: UIColor? {
        switch rawState {
        case IssueState.open.rawValue where isIssue: return Styles.Colors.Green.medium.color
        case IssueState.closed.rawValue where isIssue: return Styles.Colors.Red.medium.color
        case PullRequestState.open.rawValue where !isIssue: return Styles.Colors.Green.medium.color
        case PullRequestState.closed.rawValue where !isIssue: return Styles.Colors.Red.medium.color
        case PullRequestState.merged.rawValue where !isIssue: return Styles.Colors.purple.color
        default: return nil
        }
    }
}

class IssueSummaryModel: ListDiffable {
    let info: IssueSummaryType
    
    init(info: IssueSummaryType) {
        self.info = info
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return info.id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueSummaryModel else { return false }
        return info.id == object.info.id &&
               info.attributedTitle == object.info.attributedTitle &&
               info.number == object.info.number &&
               info.rawState == object.info.rawState
    }
}
