//
//  IssueMilestoneEventCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import SnapKit

protocol IssueMilestoneEventCellDelegate: class {
    func didTapActor(cell: IssueMilestoneEventCell)
}

final class IssueMilestoneEventCell: UICollectionViewCell {

    weak var delegate: IssueMilestoneEventCellDelegate?

    private let actorButton = UIButton()
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        actorButton.addTarget(self, action: #selector(IssueMilestoneEventCell.onActor), for: .touchUpInside)
        contentView.addSubview(actorButton)
        actorButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.eventGutter)
        }

        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = .clear
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(actorButton)
            make.left.equalTo(actorButton.snp.right)
            make.right.lessThanOrEqualTo(-Styles.Sizes.eventGutter)
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
    func onActor() {
        delegate?.didTapActor(cell: self)
    }

    // MARK: Public API

    func configure(_ model: IssueMilestoneEventModel) {
        let boldAttributes = [
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color,
            NSAttributedStringKey.font: Styles.Fonts.secondaryBold
        ]

        let actor = NSAttributedString(string: model.actor, attributes: boldAttributes)
        actorButton.setAttributedTitle(actor, for: .normal)

        let separatorAttributes = [
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.medium.color,
            NSAttributedStringKey.font: Styles.Fonts.secondary
        ]

        let action: String
        switch model.type {
        case .milestoned: action = NSLocalizedString(" added to milestone ", comment: "")
        case .demilestoned: action = NSLocalizedString(" removed from milestone ", comment: "")
        }
        let text = NSMutableAttributedString(string: action, attributes: separatorAttributes)
        text.append(NSAttributedString(string: model.milestone, attributes: boldAttributes))
        label.attributedText = text
    }

}
