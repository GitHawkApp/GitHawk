//
//  IssueRequestCell.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 7/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol IssueRequestCellDelegate: class {
    func didTapActor(cell: IssueRequestCell)
    func didTapUser(cell: IssueRequestCell)
}

final class IssueRequestCell: UICollectionViewCell {

    weak var delegate: IssueRequestCellDelegate? = nil

    private let actorButton = UIButton()
    private let userButton = UIButton()
    private let dateLabel = ShowMoreDetailsLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        actorButton.addTarget(self, action: #selector(IssueRequestCell.onActor), for: .touchUpInside)
        contentView.addSubview(actorButton)
        actorButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.eventGutter)
        }

        userButton.addTarget(self, action: #selector(IssueRequestCell.onUser), for: .touchUpInside)
        contentView.addSubview(userButton)
        userButton.snp.makeConstraints { make in
            make.centerY.equalTo(actorButton)
            make.left.equalTo(actorButton.snp.right).offset(Styles.Sizes.inlineSpacing)
        }

        dateLabel.font = Styles.Fonts.secondary
        dateLabel.textColor = Styles.Colors.Gray.medium.color
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userButton)
            make.left.equalTo(userButton.snp.right).offset(Styles.Sizes.inlineSpacing)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private API

    @objc
    func onActor() {
        delegate?.didTapActor(cell: self)
    }

    @objc
    func onUser() {
        delegate?.didTapUser(cell: self)
    }

    // MARK: Public API

    func configure(_ model: IssueRequestModel) {
        let actorAttributes = [
            NSAttributedStringKey.font: Styles.Fonts.secondaryBold,
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color
        ]
        let phraseAttributes = [
            NSAttributedStringKey.font: Styles.Fonts.secondary,
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.medium.color
        ]

        let phrase: String
        switch model.event {
        case .assigned: phrase = NSLocalizedString(" assigned", comment: "")
        case .unassigned: phrase = NSLocalizedString(" unassigned", comment: "")
        case .reviewRequested: phrase = NSLocalizedString(" requested", comment: "")
        case .reviewRequestRemoved: phrase = NSLocalizedString(" removed", comment: "")
        }

        let actor = NSMutableAttributedString(string: model.actor, attributes: actorAttributes)
        actor.append(NSAttributedString(string: phrase, attributes: phraseAttributes))
        actorButton.setAttributedTitle(actor, for: .normal)

        let user = NSAttributedString(string: model.user, attributes: actorAttributes)
        userButton.setAttributedTitle(user, for: .normal)

        dateLabel.setText(date: model.date)
    }

}
