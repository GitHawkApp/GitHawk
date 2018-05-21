//
//  NotificationDetailsCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import StyledText

final class NotificationCell: SwipeSelectableCell {

    static let labelInset = UIEdgeInsets(
        top: Styles.Text.title.preferredFont.lineHeight + 2*Styles.Sizes.rowSpacing,
        left: Styles.Sizes.icon.width + 2*Styles.Sizes.columnSpacing,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter + Styles.Sizes.icon.width + Styles.Sizes.columnSpacing
    )

    static var minHeight: CGFloat {
        // comment icon
        return Styles.Sizes.icon.height
            // date, comment count labels
            + 2 * Styles.Text.secondary.preferredFont.lineHeight
            // padding
            + 3 * Styles.Sizes.rowSpacing
    }

    private let reasonImageView = UIImageView()
    private let dateLabel = ShowMoreDetailsLabel()
    private let titleLabel = UILabel()
    private let textView = StyledTextView()
    private let commentLabel = UILabel()
    private let commentImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true

        backgroundColor = .white

        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(reasonImageView)
        contentView.addSubview(textView)
        contentView.addSubview(commentImageView)
        contentView.addSubview(commentLabel)

        titleLabel.numberOfLines = 1
        titleLabel.font = Styles.Text.title.preferredFont
        titleLabel.textColor = Styles.Colors.Gray.light.color
        titleLabel.lineBreakMode = .byTruncatingMiddle
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(Styles.Sizes.rowSpacing)
            make.left.equalTo(NotificationCell.labelInset.left)
            make.right.lessThanOrEqualTo(dateLabel.snp.left).offset(-Styles.Sizes.columnSpacing)
        }

        dateLabel.backgroundColor = .clear
        dateLabel.numberOfLines = 1
        dateLabel.font = Styles.Text.secondary.preferredFont
        dateLabel.textColor = Styles.Colors.Gray.light.color
        dateLabel.textAlignment = .right
        dateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        dateLabel.snp.makeConstraints { make in
            make.right.equalTo(-Styles.Sizes.gutter)
            make.centerY.equalTo(titleLabel)
        }

        reasonImageView.backgroundColor = .clear
        reasonImageView.contentMode = .scaleAspectFit
        reasonImageView.snp.makeConstraints { make in
            make.size.equalTo(Styles.Sizes.icon)
            make.top.equalTo(NotificationCell.labelInset.top)
            make.left.equalTo(Styles.Sizes.rowSpacing)
        }

        commentImageView.tintColor = dateLabel.textColor
        commentImageView.image = UIImage(named: "comment-small")?.withRenderingMode(.alwaysTemplate)
        commentImageView.backgroundColor = .clear
        commentImageView.snp.makeConstraints { make in
            make.right.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(Styles.Sizes.rowSpacing)
        }

        commentLabel.font = dateLabel.font
        commentLabel.textColor = dateLabel.textColor
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(commentImageView.snp.bottom)
            make.centerX.equalTo(commentImageView)
        }

        contentView.addBorder(.bottom, left: NotificationCell.labelInset.left)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
        textView.reposition(width: contentView.bounds.width)
    }

    // MARK: Public API

    var isRead = false {
        didSet {
            for view in [titleLabel, textView, reasonImageView] {
                view.alpha = isRead ? 0.5 : 1
            }
        }
    }

    func configure(_ viewModel: NotificationViewModel) {
        var titleAttributes = [
            NSAttributedStringKey.font: Styles.Text.title.preferredFont,
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.light.color
        ]
        let title = NSMutableAttributedString(string: "\(viewModel.owner)/\(viewModel.repo) ", attributes: titleAttributes)

        titleAttributes[NSAttributedStringKey.font] = Styles.Text.secondary.preferredFont
        switch viewModel.identifier {
        case .number(let number): title.append(NSAttributedString(string: "#\(number)", attributes: titleAttributes))
        default: break
        }
        titleLabel.attributedText = title

        textView.configure(renderer: viewModel.title, width: contentView.bounds.width)

        dateLabel.setText(date: viewModel.date)
        reasonImageView.image = viewModel.type.icon.withRenderingMode(.alwaysTemplate)
        accessibilityLabel = AccessibilityHelper
            .generatedLabel(forCell: self)
            .appending(".\n\(viewModel.type.localizedString)")

        let tintColor: UIColor
        switch viewModel.state {
        case .closed: tintColor = Styles.Colors.Red.medium.color
        case .merged: tintColor = Styles.Colors.purple.color
        case .open: tintColor = Styles.Colors.Green.medium.color
        case .pending: tintColor = Styles.Colors.Blue.medium.color
        }
        reasonImageView.tintColor = tintColor

        let commentHidden = viewModel.commentCount == 0
        commentLabel.isHidden = commentHidden
        commentImageView.isHidden = commentHidden
        commentLabel.text = viewModel.commentCount.abbreviated
    }

}
