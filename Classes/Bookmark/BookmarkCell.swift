//
//  BookmarkCell.swift
//  Freetime
//
//  Created by Rizwan on 01/11/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

class BookmarkCell: SwipeSelectableTableCell {

    static var cellIdentifier: String {
        return "bookmark_cell"
    }

    private let reasonImageView = UIImageView()
    private let titleLabel = UILabel()
    private let secondaryLabel = UILabel()
    private let detailsStackView = UIStackView()

    // MARK: Init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true
        titleLabel.numberOfLines = 0
        secondaryLabel.numberOfLines = 0

        backgroundColor = .white

        contentView.addSubview(reasonImageView)
        contentView.addSubview(detailsStackView)

        reasonImageView.backgroundColor = .clear
        reasonImageView.contentMode = .scaleAspectFit
        reasonImageView.tintColor = Styles.Colors.Blue.medium.color
        reasonImageView.snp.makeConstraints { make in
            make.size.equalTo(Styles.Sizes.icon)
            make.centerY.equalToSuperview()
            make.left.equalTo(Styles.Sizes.columnSpacing)
        }

        detailsStackView.axis = .vertical
        detailsStackView.alignment = .leading
        detailsStackView.distribution = .fill
        detailsStackView.spacing = Styles.Sizes.rowSpacing
        detailsStackView.addArrangedSubview(titleLabel)
        detailsStackView.addArrangedSubview(secondaryLabel)
        detailsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(Styles.Sizes.rowSpacing)
            make.bottom.equalTo(contentView).offset(-Styles.Sizes.rowSpacing)
            make.left.equalTo(reasonImageView.snp.right).offset(Styles.Sizes.columnSpacing)
            make.right.equalTo(contentView.snp.right).offset(-Styles.Sizes.columnSpacing)
        }

        addBorder(.bottom, left: RepositorySummaryCell.titleInset.left)
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
        titleLabel.attributedText = titleLabel(for: bookmark)
        secondaryLabel.text = bookmark.title
        reasonImageView.image = bookmark.type.icon.withRenderingMode(.alwaysTemplate)
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
