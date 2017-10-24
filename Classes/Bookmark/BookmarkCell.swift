//
//  BookmarkCell.swift
//  Freetime
//
//  Created by Rizwan on 23/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

class BookmarkCell: UITableViewCell {
    
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
        let ownerAttributes = [
            NSAttributedStringKey.font: Styles.Fonts.body,
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color
        ]
        let title = NSMutableAttributedString(string: bookmark.owner + "/", attributes: ownerAttributes)
        let nameAttributes = [
            NSAttributedStringKey.font: Styles.Fonts.bodyBold,
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color
        ]
        title.append(NSAttributedString(string: bookmark.name, attributes: nameAttributes))
    
        switch bookmark.type {
        case .issue, .pullRequest:
            title.append(NSAttributedString(string: " #\(bookmark.number)", attributes: ownerAttributes))
        default:
            break
        }
        
        textLabel?.attributedText = title
        detailTextLabel?.text = bookmark.title
        imageView?.image = bookmark.type.icon?.withRenderingMode(.alwaysTemplate)
        imageView?.tintColor = Styles.Colors.Blue.medium.color
    }

}
