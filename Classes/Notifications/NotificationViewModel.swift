//
//  NotificationViewModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import FlatCache
import DateAgo

final class NotificationViewModel: ListDiffable, Cachable {

    enum Identifier {
        case number(Int)
        case hash(String)
        case release(String)
    }

    // combining possible issue and PR states
    // https://developer.github.com/v4/enum/issuestate/
    // https://developer.github.com/v4/enum/pullrequeststate/
    enum State: String {
        case pending
        case closed = "CLOSED"
        case merged = "MERGED"
        case open = "OPEN"
    }

    let id: String
    let title: NSAttributedStringSizing
    let type: NotificationType
    let date: Date
    let agoString: String
    let read: Bool
    let owner: String
    let repo: String
    let identifier: Identifier
    let state: State
    let commentCount: Int

    init(
    id: String,
    title: NSAttributedStringSizing,
    type: NotificationType,
    date: Date,
    read: Bool,
    owner: String,
    repo: String,
    identifier: Identifier,
    state: State,
    commentCount: Int
        ) {
        self.id = id
        self.title = title
        self.type = type
        self.date = date
        self.read = read
        self.owner = owner
        self.repo = repo
        self.identifier = identifier
        self.state = state
        self.commentCount = commentCount
        self.agoString = date.agoString(.long)
    }

    convenience init(
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
        let attributes = [
            NSAttributedStringKey.font: Styles.Text.body.preferredFont,
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color
        ]
        let title = NSAttributedStringSizing(
            containerWidth: containerWidth,
            attributedText: NSAttributedString(string: title, attributes: attributes),
            inset: NotificationCell.labelInset
        )
        self.init(
            id: id,
            title: title,
            type: type,
            date: date,
            read: read,
            owner: owner,
            repo: repo,
            identifier: identifier,
            state: .pending,
            commentCount: 0
        )
    }

    // MARK: Public API

    func updated(
        id: String? = nil,
        title: NSAttributedStringSizing? = nil,
        type: NotificationType? = nil,
        date: Date? = nil,
        read: Bool? = nil,
        owner: String? = nil,
        repo: String? = nil,
        identifier: Identifier? = nil,
        state: State? = nil,
        commentCount: Int? = nil
        ) -> NotificationViewModel {
        return NotificationViewModel(
            id: id ?? self.id,
            title: title ?? self.title,
            type: type ?? self.type,
            date: date ?? self.date,
            read: read ?? self.read,
            owner: owner ?? self.owner,
            repo: repo ?? self.repo,
            identifier: identifier ?? self.identifier,
            state: state ?? self.state,
            commentCount: commentCount ?? self.commentCount
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
            && agoString == object.agoString
            && repo == object.repo
            && owner == object.owner
            && state == object.state
            && title.attributedText.string == object.title.attributedText.string
    }

}
