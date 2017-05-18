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
    let titleSize: CGSize
    let type: NotificationType
    let date: Date
    let read: Bool
    let owner: String
    let repo: String
    let issueNumber: String

    init(
        title: String,
        type: NotificationType,
        date: Date,
        read: Bool,
        owner: String,
        repo: String,
        issueNumber: String,
        containerWidth: CGFloat
        ) {
        self.type = type
        self.date = date
        self.read = read
        self.owner = owner
        self.repo = repo
        self.issueNumber = issueNumber

        let attributes = [
            NSFontAttributeName: Styles.Fonts.body,
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark
        ]
        self.title = NSAttributedString(string: title, attributes: attributes)

        let sizing = NSAttributedStringSizing(
            containerWidth: containerWidth,
            attributedText: self.title,
            inset: NotificationCell.labelInset
        )
        self.titleSize = sizing.textViewSize
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
