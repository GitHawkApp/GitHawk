//
//  IssueClosedCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueClosedCell: UICollectionViewCell {

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

        button.tintColor = .white
        button.titleLabel?.font = Styles.Fonts.smallTitle
        button.layer.cornerRadius = Styles.Sizes.avatarCornerRadius
        button.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -Styles.Sizes.columnSpacing, bottom: 0, right: 0)
        button.contentEdgeInsets = UIEdgeInsets(top: 2, left: Styles.Sizes.columnSpacing + 2, bottom: 2, right: 4)
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.left.equalTo(label.snp.right).offset(Styles.Sizes.columnSpacing)
            make.centerY.equalTo(contentView)
        }

        dateLabel.font = Styles.Fonts.body
        dateLabel.textColor = Styles.Colors.Gray.medium
        dateLabel.backgroundColor = .clear
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(button.snp.right).offset(Styles.Sizes.columnSpacing)
            make.centerY.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(_ model: IssueClosedModel) {
        let actorAttributes = [
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark,
            NSFontAttributeName: Styles.Fonts.bodyBold
        ]
        label.attributedText = NSAttributedString(string: model.actor, attributes: actorAttributes)

        let title: String
        let color: UIColor
        let iconName: String
        let prName = "git-pull-request-small"
        if model.closed {
            title = Strings.closed
            color = Styles.Colors.red
            iconName = model.pullRequest ? "issue-closed-small" : prName
        } else {
            title = Strings.reopened
            color = Styles.Colors.green
            iconName = model.pullRequest ? "issue-opened-small" : prName
        }
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.backgroundColor = color

        dateLabel.text = model.date.agoString
        dateLabel.detailText = DateDetailsFormatter().string(from: model.date)
    }

}
