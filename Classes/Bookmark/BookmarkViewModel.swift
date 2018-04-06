//
//  BookmarkViewModel.swift
//  Freetime
//
//  Created by Hesham Salman on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import StyledText

final class BookmarkViewModel: ListDiffable {

    let bookmark: Bookmark
    let text: StyledTextRenderer

    private let _diffIdentifier: NSObjectProtocol

    init(bookmark: Bookmark, contentSizeCategory: UIContentSizeCategory, width: CGFloat) {
        self.bookmark = bookmark

        let builder = StyledTextBuilder(styledText: StyledText(
            style: Styles.Text.body.with(foreground: Styles.Colors.Gray.dark.color)
        ))
        switch bookmark.type {
        case .issue, .pullRequest:
            builder.add(text: bookmark.title)
        case .commit, .repo:
            builder.add(text: "\(bookmark.owner)/")
                .add(text: bookmark.name, traits: .traitBold)
        case .release:
            builder.add(text: bookmark.title)
        }

        text = StyledTextRenderer(
            string: builder.build(),
            contentSizeCategory: contentSizeCategory,
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
