//
//  IssueRenamedCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol IssueRenamedCellDelegate: class {
    func didTapActor(cell: IssueRenamedCell)
}

final class IssueRenamedCell: UICollectionViewCell {

    static let titleInset = UIEdgeInsets(
        top: Styles.Sizes.labelEventHeight,
        left: Styles.Sizes.eventGutter,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.eventGutter
    )

    weak var delegate: IssueRenamedCellDelegate?

    private let actorLabel = UIButton()
    private let dateLabel = ShowMoreDetailsLabel()
    private let titleView = AttributedStringView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        actorLabel.contentEdgeInsets = .zero
        actorLabel.addTarget(self, action: #selector(IssueRenamedCell.onActor), for: .touchUpInside)
        contentView.addSubview(actorLabel)
        actorLabel.snp.makeConstraints { make in
            make.left.equalTo(IssueRenamedCell.titleInset.left)
            make.top.equalTo(0)
        }

        dateLabel.font = Styles.Text.secondary.preferredFont
        dateLabel.textColor = Styles.Colors.Gray.medium.color
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(actorLabel.snp.right).offset(Styles.Sizes.inlineSpacing)
            make.centerY.equalTo(actorLabel)
        }

        contentView.addSubview(titleView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
        titleView.reposition(width: contentView.bounds.width)
    }

    // MARK: Private API

    @objc func onActor() {
        delegate?.didTapActor(cell: self)
    }

    // MARK: Public API

    func configure(_ model: IssueRenamedModel) {
        let actorAttributes = [
            NSAttributedStringKey.font: Styles.Text.secondaryBold.preferredFont,
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color
        ]
        let actor = NSMutableAttributedString(string: model.actor, attributes: actorAttributes)
        let referencedAttributes = [
            NSAttributedStringKey.font: Styles.Text.secondary.preferredFont,
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.medium.color
        ]
        actor.append(NSAttributedString(
            string: NSLocalizedString(" renamed", comment: ""),
            attributes: referencedAttributes
            ))
        actorLabel.setAttributedTitle(actor, for: .normal)

        dateLabel.setText(date: model.date)

        titleView.configureAndSizeToFit(text: model.titleChangeString, width: contentView.bounds.width)
    }

}
