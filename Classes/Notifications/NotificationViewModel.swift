//
//  NotificationViewModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class NotificationViewModel {

    let title: NSAttributedString
    let type: NotificationType
    let date: Date
    let read: Bool

    init(
        title: String,
        type: NotificationType,
        date: Date,
        read: Bool
        ) {
        self.type = type
        self.date = date
        self.read = read

        let attributes = [
            NSFontAttributeName: Styles.Fonts.body,
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark
        ]
        self.title = NSAttributedString(string: title, attributes: attributes)
    }

}

extension NotificationViewModel: IGListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return date as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? NotificationViewModel else { return false }
        return read == object.read
        && type == object.type
        && title == object.title
    }

}
