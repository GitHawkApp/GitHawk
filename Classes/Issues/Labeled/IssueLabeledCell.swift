//
//  IssueLabeledCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueLabeledCell: UICollectionViewCell {

    let descriptionLabel = UILabel()
    let labelBackgroundView = UIView()
    let titleLabel = UILabel()
    let dateLabel = ShowMoreDetailsLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        descriptionLabel.backgroundColor = .clear
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.centerY.equalTo(contentView)
        }

        titleLabel.font = Styles.Fonts.smallTitle
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(descriptionLabel.snp.right).offset(Styles.Sizes.inlineSpacing * 2)
            make.centerY.equalTo(descriptionLabel)
        }

        // even though the background view is behind the title, add it second so that constraints can be setup
        labelBackgroundView.layer.cornerRadius = Styles.Sizes.avatarCornerRadius
        labelBackgroundView.clipsToBounds = true
        contentView.addSubview(labelBackgroundView)
        labelBackgroundView.snp.makeConstraints { make in
            make.center.equalTo(titleLabel)
            make.width.equalTo(titleLabel).offset(Styles.Sizes.inlineSpacing * 2)
            make.height.equalTo(titleLabel).offset(Styles.Sizes.rowSpacing)
        }

        // then swap the z indexes of the label and background
        contentView.bringSubview(toFront: titleLabel)

        dateLabel.font = Styles.Fonts.body
        dateLabel.textColor = Styles.Colors.Gray.medium
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(labelBackgroundView.snp.right).offset(Styles.Sizes.inlineSpacing)
            make.centerY.equalTo(contentView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(_ model: IssueLabeledModel) {
        let actorAttributes = [
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark,
            NSFontAttributeName: Styles.Fonts.bodyBold
        ]
        let actor = NSAttributedString(string: model.actor, attributes: actorAttributes)

        let actionString: String
        switch model.type {
        case .added: actionString = NSLocalizedString(" added", comment: "")
        case .removed: actionString = NSLocalizedString(" removed", comment: "")
        }
        let actionAttributes = [
            NSForegroundColorAttributeName: Styles.Colors.Gray.medium,
            NSFontAttributeName: Styles.Fonts.body
        ]
        let action = NSAttributedString(string: actionString, attributes: actionAttributes)
        let descriptionText = NSMutableAttributedString(attributedString: actor)
        descriptionText.append(action)
        descriptionLabel.attributedText = descriptionText

        let color = UIColor.fromHex(model.color)
        labelBackgroundView.backgroundColor = color

        titleLabel.text = model.title
        titleLabel.textColor = color.textOverlayColor

        dateLabel.text = model.date.agoString
        dateLabel.detailText = DateDetailsFormatter().string(from: model.date)
    }

}
