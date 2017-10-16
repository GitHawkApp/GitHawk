//
//  IssueReferencedCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol IssueReferencedCommitCellDelegate: class {
    func didTapActor(cell: IssueReferencedCommitCell)
    func didTapHash(cell: IssueReferencedCommitCell)
}

final class IssueReferencedCommitCell: UICollectionViewCell {

    weak var delegate: IssueReferencedCommitCellDelegate? = nil

    private let nameButton = UIButton()
    private let referencedButton = UIButton()
    private let dateLabel = ShowMoreDetailsLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        nameButton.setTitleColor(Styles.Colors.Gray.dark.color, for: .normal)
        nameButton.titleLabel?.font = Styles.Fonts.secondaryBold
        nameButton.addTarget(self, action: #selector(IssueReferencedCommitCell.onName), for: .touchUpInside)
        contentView.addSubview(nameButton)
        nameButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.eventGutter)
        }

        referencedButton.addTarget(self, action: #selector(IssueReferencedCommitCell.onHash), for: .touchUpInside)
        contentView.addSubview(referencedButton)
        referencedButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameButton)
            make.left.equalTo(nameButton.snp.right).offset(4)
        }

        dateLabel.font = Styles.Fonts.secondary
        dateLabel.textColor = Styles.Colors.Gray.medium.color
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(referencedButton.snp.right).offset(3)
            make.centerY.equalTo(referencedButton)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
    }

    // MARK: Private API

    @objc
    func onName() {
        delegate?.didTapActor(cell: self)
    }

    @objc
    func onHash() {
        delegate?.didTapHash(cell: self)
    }

    // MARK: Public API

    func configure(_ model: IssueReferencedCommitModel) {
        nameButton.setTitle(model.actor, for: .normal)

        let referenceAttributes = [
            NSAttributedStringKey.font: Styles.Fonts.secondary,
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.medium.color,
        ]
        let title = NSMutableAttributedString(
            string: NSLocalizedString("referenced ", comment: ""),
            attributes: referenceAttributes
        )
        let hashAttributes = [
            NSAttributedStringKey.font: Styles.Fonts.code.addingTraits(traits: .traitBold),
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color
        ]
        title.append(NSAttributedString(string: model.hash.hashDisplay, attributes: hashAttributes))
        referencedButton.setAttributedTitle(title, for: .normal)

        dateLabel.setText(date: model.date)
    }

}
