//
//  IssueMergedCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/29/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol IssueMergedCellDelegate: class {
    func didTapActor(cell: IssueMergedCell)
    func didTapHash(cell: IssueMergedCell)
}

final class IssueMergedCell: UICollectionViewCell {

    weak var delegate: IssueMergedCellDelegate? = nil

    private let actorLabel = UIButton()
    private let hashLabel = UIButton()
    private let button = UIButton()
    private let dateLabel = ShowMoreDetailsLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        actorLabel.titleLabel?.font = Styles.Fonts.bodyBold
        actorLabel.setTitleColor(Styles.Colors.Gray.dark.color, for: .normal)
        contentView.addSubview(actorLabel)
        actorLabel.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.centerY.equalTo(contentView)
        }

        button.setTitle(Strings.merged, for: .normal)
        button.setupAsLabel()
        button.config(pullRequest: false, state: .merged)
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.left.equalTo(actorLabel.snp.right).offset(Styles.Sizes.inlineSpacing)
            make.centerY.equalTo(contentView)
        }

        hashLabel.titleLabel?.font = UIFont(name: "Courier-Bold", size: Styles.Sizes.Text.body)
        hashLabel.setTitleColor(Styles.Colors.Gray.dark.color, for: .normal)
        contentView.addSubview(hashLabel)
        hashLabel.snp.makeConstraints { make in
            make.left.equalTo(button.snp.right).offset(Styles.Sizes.inlineSpacing)
            make.centerY.equalTo(contentView)
        }

        dateLabel.font = Styles.Fonts.body
        dateLabel.textColor = Styles.Colors.Gray.medium.color
        dateLabel.backgroundColor = .clear
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(hashLabel.snp.right).offset(Styles.Sizes.inlineSpacing)
            make.centerY.equalTo(contentView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(viewModel: IssueMergedModel) {
        actorLabel.setTitle(viewModel.actor, for: .normal)
        dateLabel.setText(date: viewModel.date)
        hashLabel.setTitle(viewModel.commitHash.hashDisplay, for: .normal)
    }
}
