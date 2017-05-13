//
//  RepoNotifications.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class RepoNotifications {

    let repoName: String
    let notifications: [NotificationViewModel]

    init(
        repoName: String,
        notifications: [NotificationViewModel]
        ) {
        self.repoName = repoName
        self.notifications = notifications
    }

}

extension RepoNotifications: IGListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return repoName as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if self === object { return true }
        return object is RepoNotifications
    }

}
