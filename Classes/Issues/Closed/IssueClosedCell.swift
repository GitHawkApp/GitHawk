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

    func configure(_ model: IssueClosedModel) {
        let actorAttributes = [
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color ?? .black,
            NSFontAttributeName: Styles.Fonts.bodyBold
        ]
        label.attributedText = NSAttributedString(string: model.actor, attributes: actorAttributes)

        button.setStatusIcon(pullRequest: model.pullRequest, closed: model.closed)
        button.setBackgroundColor(closed: model.closed)
        button.setTitle(model.closed ? Strings.closed : Strings.reopened, for: .normal)

        dateLabel.setText(date: model.date)
    }

}
