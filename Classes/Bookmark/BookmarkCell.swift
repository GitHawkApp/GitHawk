//
//  BookmarkCell.swift
//  Freetime
//
//  Created by Rizwan on 01/11/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

class BookmarkCell: SwipeSelectableTableCell {

    static var cellIdentifier: String {
        return "bookmark_cell"
    }

    // MARK: Init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
    }

    // MARK: - Accessibility

    override var accessibilityLabel: String? {
        get {
            return contentView.subviews
                .flatMap { $0.accessibilityLabel }
                .reduce("", { "\($0 ?? "").\n\($1)" })
        }
        set { }
    }

    // MARK: Public API

    func configure(bookmark: BookmarkModel) {
        textLabel?.attributedText = titleLabel(for: bookmark)
        detailTextLabel?.text = bookmark.title
        imageView?.image = bookmark.type.icon?.withRenderingMode(.alwaysTemplate)
        imageView?.tintColor = Styles.Colors.Blue.medium.color
    }

    private func titleLabel(for bookmark: BookmarkModel) -> NSAttributedString {
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
}
