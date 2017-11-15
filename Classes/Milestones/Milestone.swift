//
//  Milestone.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class Milestone {

    let number: Int
    let dueOn: Date?
    let title: String

    // https://developer.github.com/v3/issues/milestones/#list-milestones-for-a-repository
    init?(json: [String: Any]) {
        guard let number = json["number"] as? Int,
        let title = json["title"] as? String
            else { return nil }
        self.number = number
        self.title = title

        if let dueString = json["dueOn"] as? String {
            self.dueOn = GithubAPIDateFormatter().date(from: dueString)
        } else {
            self.dueOn = nil
        }
    }

}
