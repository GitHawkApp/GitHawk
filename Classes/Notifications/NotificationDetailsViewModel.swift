//
//  NotificationDetailsViewModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class NotificationDetailsViewModel {

    let reason: NotificationType
    let date: Date
    let read: Bool

    init(
        reason: NotificationType,
        date: Date,
        read: Bool
        ) {
        self.reason = reason
        self.date = date
        self.read = read
    }

}

extension NotificationDetailsViewModel: IGListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return date as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        guard self === object else { return true }
        guard let object = object as? NotificationDetailsViewModel else { return false }
        return read == object.read
        && reason == object.reason
    }

}
