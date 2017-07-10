//
//  IssueReferencedCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueReferencedCommitCell: UICollectionViewCell {

    let nameButton = UIButton()
    let referencedLabel = UILabel()
    let dateLabel = ShowMoreDetailsLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        nameButton.titleLabel?.font = Styles.Fonts.bodyBold
        contentView.addSubview(nameButton)
        nameButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.gutter)
        }

        contentView.addSubview(referencedLabel)
        referencedLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameButton)
            make.left.equalTo(nameButton.snp.right).offset(2)
        }

        dateLabel.font = Styles.Fonts.body
        dateLabel.textColor = Styles.Colors.Gray.medium.color
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(referencedLabel.snp.right).offset(2)
            make.top.equalTo(referencedLabel)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(_ model: IssueReferencedCommitModel) {
        nameButton.setTitle(model.actor, for: .normal)

        let referenceAttributes = [
            NSFontAttributeName: Styles.Fonts.body,
            NSForegroundColorAttributeName: Styles.Colors.Gray.medium.color,
        ]
        let title = NSMutableAttributedString(
            string: NSLocalizedString("referenced in ", comment: ""),
            attributes: referenceAttributes
        )
        let hashAttributes = [
            NSFontAttributeName: Styles.Fonts.code.addingTraits(traits: .traitBold),
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color
        ]
        title.append(NSAttributedString(string: model.hash.hashDisplay, attributes: hashAttributes))
        referencedLabel.attributedText = title

        dateLabel.setText(date: model.date)
    }

}
