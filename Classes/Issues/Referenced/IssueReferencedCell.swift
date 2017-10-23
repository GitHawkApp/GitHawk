//
//  IssueReferencedCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueReferencedCell: UICollectionViewCell {

    let referencedLabel = UILabel()
    let dateLabel = ShowMoreDetailsLabel()
    let titleLabel = UILabel()
    let statusButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        referencedLabel.font = Styles.Fonts.secondary
        referencedLabel.textColor = Styles.Colors.Gray.medium.color
        referencedLabel.text = NSLocalizedString("referenced ", comment: "")
        contentView.addSubview(referencedLabel)
        referencedLabel.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.equalTo(Styles.Sizes.eventGutter)
        }

        dateLabel.font = Styles.Fonts.secondary
        dateLabel.textColor = Styles.Colors.Gray.medium.color
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(referencedLabel.snp.right)
            make.top.equalTo(referencedLabel)
        }

        statusButton.setupAsLabel(icon: false)
        contentView.addSubview(statusButton)
        statusButton.snp.makeConstraints { make in
            make.right.equalTo(-Styles.Sizes.eventGutter)
            make.top.equalTo(referencedLabel.snp.bottom).offset(2)
        }

        titleLabel.numberOfLines = 1
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(referencedLabel)
            make.right.lessThanOrEqualTo(statusButton.snp.left).offset(-Styles.Sizes.columnSpacing/2)
            make.centerY.equalTo(statusButton)
        }

        // always collapse and truncate
        titleLabel.lineBreakMode = .byTruncatingMiddle
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
    }

    // MARK: Public API

    func configure(_ model: IssueReferencedModel) {
        let titleAttributes = [
            NSAttributedStringKey.font: Styles.Fonts.secondaryBold,
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color
        ]
        let title = NSMutableAttributedString(string: model.title, attributes: titleAttributes)
        let numberAttributes = [
            NSAttributedStringKey.font: Styles.Fonts.secondary,
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.light.color
        ]
        title.append(NSAttributedString(string: " #\(model.number)", attributes: numberAttributes))
        titleLabel.attributedText = title

        dateLabel.setText(date: model.date)

        let buttonState: UIButton.State

        switch model.state {
        case .closed: buttonState = .closed
        case .merged: buttonState = .merged
        case .open: buttonState = .open
        }

        statusButton.config(pullRequest: model.pullRequest, state: buttonState)
    }

}
