//
//  BookmarkCell.swift
//  Freetime
//
//  Created by Hesham Salman on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import StyledTextKit

final class BookmarkCell: SwipeSelectableCell {

    static let titleInset = UIEdgeInsets(
        top: Styles.Sizes.rowSpacing,
        left: Styles.Sizes.icon.width + 2*Styles.Sizes.columnSpacing,
        bottom: Styles.Text.secondary.preferredFont.lineHeight + 2*Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter
    )

    private let imageView = UIImageView()
    private let textView = StyledTextView()
    private let detailLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        accessibilityIdentifier = "bookmark-cell"
        backgroundColor = .white

        contentView.clipsToBounds = true

        imageView.contentMode = .center
        imageView.tintColor = Styles.Colors.Blue.medium.color
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.columnSpacing)
            make.size.equalTo(Styles.Sizes.icon)
        }

        contentView.addSubview(textView)
        contentView.addSubview(detailLabel)

        addBorder(.bottom, left: BookmarkCell.titleInset.left)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentView()

        let bounds = contentView.bounds
        textView.reposition(for: bounds.width)

        let textViewFrame = textView.frame

        // center the textView if there is no detail text
        if detailLabel.text?.isEmpty == true {
            textView.frame = CGRect(
                origin: CGPoint(x: textViewFrame.minX, y: (bounds.height - textViewFrame.height)/2),
                size: textViewFrame.size
            )
        } else {
            detailLabel.frame = CGRect(
                origin: CGPoint(x: textViewFrame.minX, y: textViewFrame.maxY + Styles.Sizes.rowSpacing),
                size: detailLabel.frame.size
            )
        }
    }

    func configure(with model: BookmarkIssueViewModel) {
        let imageName: String
        if model.state == .merged {
            imageName = "git-merge"
        } else {
            imageName = model.isPullRequest ? "git-pull-request" : "issue-opened"
        }
        imageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)

        let tint: UIColor
        switch model.state {
        case .merged: tint = Styles.Colors.purple.color
        case .open: tint = Styles.Colors.Green.medium.color
        case .closed: tint = Styles.Colors.Red.medium.color
        case .pending: tint = Styles.Colors.Yellow.medium.color
        }
        imageView.tintColor = tint

        textView.configure(with: model.text, width: contentView.bounds.width)

        let detailString = NSMutableAttributedString(
            string: "\(model.repo.owner)/\(model.repo.name)",
            attributes: [
                .font: Styles.Text.secondaryBold.preferredFont,
                .foregroundColor: Styles.Colors.Gray.light.color
            ]
        )
        detailString.append(NSAttributedString(
            string: " #\(model.number)",
            attributes: [
                .font: Styles.Text.secondary.preferredFont,
                .foregroundColor: Styles.Colors.Gray.light.color
            ]
        ))
        detailLabel.attributedText = detailString
        detailLabel.sizeToFit()
    }

    func configureRepo(
        imageName: String,
        text: StyledTextRenderer,
        owner: String,
        name: String
        ) {
        imageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        textView.configure(with: text, width: contentView.bounds.width)
        // clear the detail for reuse
        detailLabel.text = ""
    }

}
