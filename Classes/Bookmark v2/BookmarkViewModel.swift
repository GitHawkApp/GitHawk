//
//  BookmarkViewModel.swift
//  Freetime
//
//  Created by Hesham Salman on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

class BookmarkViewModel: NSObject, ListDiffable {

    let bookmark: Bookmark

    init(bookmark: Bookmark) {
        self.bookmark = bookmark
    }

    var repositoryName: NSAttributedString {
        let repositoryText = NSMutableAttributedString(attributedString: RepositoryAttributedString(owner: bookmark.owner, name: bookmark.name))
        switch bookmark.type {
        case .issue, .pullRequest:
            let bookmarkText = NSAttributedString(string: "#\(bookmark.number)", attributes: [
                .font: Styles.Fonts.body,
                .foregroundColor: Styles.Colors.Gray.dark.color
                ]
            )
            repositoryText.append(bookmarkText)
        default:
            break
        }
        return repositoryText
    }

    var bookmarkTitle: String {
        return bookmark.title
    }

    var icon: UIImage {
        return bookmark.type.icon.withRenderingMode(.alwaysTemplate)
    }

    // MARK: - ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return "#\(bookmark.number) - \(bookmark.name) - \(bookmark.owner) - \(bookmark.title)" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
