//
//  IssueMilestoneCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/27/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueMilestoneCell: UICollectionViewCell {

    private let titleLabel = UILabel()
    private let statusLabel = UILabel()
    private let progressView = UIProgressView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        titleLabel.backgroundColor = .clear
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.equalTo(Styles.Sizes.gutter)
        }

        statusLabel.font = Styles.Fonts.secondary
        statusLabel.textColor = Styles.Colors.Gray.dark.color
        contentView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.right.equalTo(-Styles.Sizes.gutter)
            make.centerY.equalTo(titleLabel)
        }

        progressView.progressTintColor = Styles.Colors.Green.medium.color
        progressView.trackTintColor = Styles.Colors.Gray.border.color
        contentView.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Styles.Sizes.rowSpacing)
            make.left.equalTo(Styles.Sizes.gutter)
            make.right.equalTo(-Styles.Sizes.gutter)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(title: String, completed: Int, total: Int) {
        let milestoneAttributes = [
            NSForegroundColorAttributeName: Styles.Colors.Gray.light.color,
            NSFontAttributeName: Styles.Fonts.secondary
        ]
        let titleText = NSMutableAttributedString(
            string: NSLocalizedString("Milestone: ", comment: ""),
            attributes: milestoneAttributes
        )
        let titleAttributes = [
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color,
            NSFontAttributeName: Styles.Fonts.secondaryBold
        ]
        titleText.append(NSAttributedString(string: title, attributes: titleAttributes))
        
        titleLabel.attributedText = titleText
        statusLabel.text = "\(completed) / \(total)"
        progressView.progress = Float(completed) / Float(total)
    }

}
