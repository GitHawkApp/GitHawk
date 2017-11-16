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
    var text: NSAttributedStringSizing
    private let _diffIdentifier: NSObjectProtocol

    init(bookmark: Bookmark, width: CGFloat) {
        self.bookmark = bookmark

        let repositoryText = NSMutableAttributedString(
            attributedString: RepositoryAttributedString(
                owner: bookmark.owner,
                name: bookmark.name
            )
        )

        switch bookmark.type {
        case .issue, .pullRequest:
            let bookmarkText = NSAttributedString(string: "#\(bookmark.number)", attributes: [
                .font: Styles.Fonts.body,
                .foregroundColor: Styles.Colors.Gray.medium.color
                ]
            )
            repositoryText.append(bookmarkText)
        default: break
        }

        if !bookmark.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            repositoryText.append(NSAttributedString(string: "\n" + bookmark.title, attributes: [
                .font: Styles.Fonts.secondary,
                .foregroundColor: Styles.Colors.Gray.medium.color
                ])
            )
        }

        text = NSAttributedStringSizing(
            containerWidth: width,
            attributedText: repositoryText,
            inset: BookmarkCell.titleInset
        )
        _diffIdentifier = "#\(bookmark.number) - \(bookmark.name) - \(bookmark.owner) - \(bookmark.title)" as NSObjectProtocol
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return _diffIdentifier
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
