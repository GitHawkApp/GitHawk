//
//  Milestone.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class Milestone: Equatable, ListDiffable {

    let number: Int
    let dueOn: Date?
    let title: String
    let openIssueCount: Int
    let totalIssueCount: Int

    init(number: Int, title: String, dueOn: Date?, openIssueCount: Int, totalIssueCount: Int) {
        self.number = number
        self.title = title
        self.dueOn = dueOn
        self.openIssueCount = openIssueCount
        self.totalIssueCount = totalIssueCount
    }

    // https://developer.github.com/v3/issues/milestones/#list-milestones-for-a-repository
    convenience init?(json: [String: Any]) {
        guard let number = json["number"] as? Int,
            let title = json["title"] as? String,
            let open = json["open_issues"] as? Int,
            let closed = json["closed_issues"] as? Int
            else { return nil }

        let dueOn: Date?
        if let dueString = json["due_on"] as? String {
            dueOn = GithubAPIDateFormatter().date(from: dueString)
        } else {
            dueOn = nil
        }

        self.init(number: number, title: title, dueOn: dueOn, openIssueCount: open, totalIssueCount: open + closed)
    }

    // MARK: Equatable

    static func ==(lhs: Milestone, rhs: Milestone) -> Bool {
        if lhs === rhs { return true }
        return lhs.number == rhs.number
        && lhs.dueOn == rhs.dueOn
        && lhs.title == rhs.title
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return "milestone\(number)\(title)" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Milestone else { return false }
        return self == object
    }

}
