//
//  IssueStatusEventCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol IssueStatusEventCellDelegate: class {
    func didTapActor(cell: IssueStatusEventCell)
}

final class IssueStatusEventCell: UICollectionViewCell {

    weak var delegate: IssueStatusEventCellDelegate? = nil

    private let actorButton = UIButton()
    private let button = UIButton()
    private let dateLabel = ShowMoreDetailsLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        actorButton.addTarget(self, action: #selector(IssueStatusEventCell.onActor), for: .touchUpInside)
        contentView.addSubview(actorButton)
        actorButton.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.centerY.equalTo(contentView)
        }

        button.setupAsLabel()
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.left.equalTo(actorButton.snp.right).offset(Styles.Sizes.inlineSpacing)
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

    // MARK: Private API

    func onActor() {
        delegate?.didTapActor(cell: self)
    }

    // MARK: Public API

    func configure(_ model: IssueStatusEventModel) {
        let actorAttributes = [
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color,
            NSFontAttributeName: Styles.Fonts.bodyBold
        ]
        actorButton.setAttributedTitle(NSAttributedString(string: model.actor, attributes: actorAttributes), for: .normal)

        button.config(pullRequest: model.pullRequest, state: model.status.buttonState)

        let title: String
        switch model.status {
        case .reopened: title = Strings.reopened // open event only happens when RE-opening
        case .closed: title = Strings.closed
        case .locked: title = Strings.locked
        case .unlocked: title = NSLocalizedString("Unlocked", comment: "")
        case .merged: fatalError("Merge events handled in other model+cell")
        }
        button.setTitle(title, for: .normal)

        dateLabel.setText(date: model.date)
    }

}
