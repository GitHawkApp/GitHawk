//
//  NotificationViewModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class NotificationViewModel: ListDiffable {

    enum Identifier {
        case number(Int)
        case hash(String)
    }

    let id: String
    let title: NSAttributedStringSizing
    let type: NotificationType
    let date: Date
    let read: Bool
    let owner: String
    let repo: String
    let identifier: Identifier

    init(
        id: String,
        title: String,
        type: NotificationType,
        date: Date,
        read: Bool,
        owner: String,
        repo: String,
        identifier: Identifier,
        containerWidth: CGFloat
        ) {
        self.id = id
        self.type = type
        self.date = date
        self.read = read
        self.owner = owner
        self.repo = repo
        self.identifier = identifier

        let attributes = [
            NSFontAttributeName: Styles.Fonts.body,
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color
        ]
        self.title = NSAttributedStringSizing(
            containerWidth: containerWidth,
            attributedText: NSAttributedString(string: title, attributes: attributes),
            inset: NotificationCell.labelInset
        )
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? NotificationViewModel else { return false }
        return read == object.read
            && type == object.type
            && date == object.date
            && repo == object.repo
            && owner == object.owner
    }

}
