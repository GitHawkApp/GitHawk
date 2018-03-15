//
//  BookmarkViewModel.swift
//  Freetime
//
//  Created by Hesham Salman on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class BookmarkViewModel: ListDiffable {

    let bookmark: Bookmark
    let text: NSAttributedStringSizing

    private let _diffIdentifier: NSObjectProtocol

    init(bookmark: Bookmark, width: CGFloat) {
        self.bookmark = bookmark

        let attributes: [NSAttributedStringKey: Any] = [
            .font: Styles.Text.body.preferredFont,
            .foregroundColor: Styles.Colors.Gray.dark.color
        ]

        let attributedText: NSAttributedString
        switch bookmark.type {
        case .issue, .pullRequest:
            attributedText = NSAttributedString(string: bookmark.title, attributes: attributes)
        case .commit, .repo:
            let mAttributedText = NSMutableAttributedString(string: "\(bookmark.owner)/", attributes: attributes)
            mAttributedText.append(NSAttributedString(string: bookmark.name, attributes: [
                .font: Styles.Text.bodyBold.preferredFont,
                .foregroundColor: Styles.Colors.Gray.dark.color
                ]
            ))
            attributedText = mAttributedText
        case .release:
            // TODO does this even exist?
            attributedText = NSAttributedString(string: bookmark.title, attributes: attributes)
        }

        text = NSAttributedStringSizing(
            containerWidth: width,
            attributedText: attributedText,
            inset: BookmarkCell.titleInset
        )
        _diffIdentifier = "#\(bookmark.number)\(bookmark.name)\(bookmark.owner)\(bookmark.title)" as NSObjectProtocol
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return _diffIdentifier
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
