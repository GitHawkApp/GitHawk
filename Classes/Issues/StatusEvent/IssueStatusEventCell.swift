//
//  IssueStatusEventCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueStatusEventCell: UICollectionViewCell {

    private let label = UILabel()
    private let button = UIButton()
    private let dateLabel = ShowMoreDetailsLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.backgroundColor = .clear
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.centerY.equalTo(contentView)
        }

        button.setupAsLabel()
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.left.equalTo(label.snp.right).offset(Styles.Sizes.inlineSpacing)
            make.centerY.equalTo(contentView)
        }

        dateLabel.font = Styles.Fonts.body
        dateLabel.textColor = Styles.Colors.Gray.medium.color
        dateLabel.backgroundColor = .clear
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(button.snp.right).offset(Styles.Sizes.inlineSpacing)
            make.centerY.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(_ model: IssueStatusEventModel) {
        let actorAttributes = [
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color,
            NSFontAttributeName: Styles.Fonts.bodyBold
        ]
        label.attributedText = NSAttributedString(string: model.actor, attributes: actorAttributes)

        button.config(pullRequest: model.pullRequest, status: model.status)

        let title: String
        switch model.status {
        case .open: title = Strings.reopened // open event only happens when RE-opening
        case .closed: title = Strings.closed
        case .merged: fatalError("Merge events handled in other model+cell")
        }
        button.setTitle(title, for: .normal)

        dateLabel.setText(date: model.date)
    }

}
