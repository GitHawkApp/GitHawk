//
//  IssueMilestoneCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/27/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueMilestoneCell: SelectableCell {

    private let titleLabel = UILabel()
    private let progress = UIProgressView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        titleLabel.backgroundColor = .clear
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.gutter)
        }

        progress.progressTintColor = Styles.Colors.Green.medium.color
        progress.trackTintColor = Styles.Colors.Gray.border.color
        contentView.addSubview(progress)
        progress.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.height.equalTo(6)
            make.left.equalTo(titleLabel.snp.right).offset(Styles.Sizes.rowSpacing)
            // fit to gutter on all iphones, cap in landscape or ipad
            make.width.equalTo(300)
            make.right.lessThanOrEqualTo(contentView).offset(-Styles.Sizes.gutter)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(milestone: Milestone) {
        let milestoneAttributes = [
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.light.color,
            NSAttributedStringKey.font: Styles.Fonts.secondary
        ]
        let titleText = NSMutableAttributedString(
            string: NSLocalizedString("Milestone: ", comment: ""),
            attributes: milestoneAttributes
        )
        let titleAttributes = [
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color,
            NSAttributedStringKey.font: Styles.Fonts.secondaryBold
        ]
        titleText.append(NSAttributedString(string: milestone.title, attributes: titleAttributes))
        titleLabel.attributedText = titleText

        progress.progress = Float(milestone.openIssueCount) / Float(milestone.totalIssueCount)
    }

}
