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

    private let actorButton = UIButton()
    private let hashButton = UIButton()
    private let mergedButton = UIButton()
    private let dateLabel = ShowMoreDetailsLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        actorButton.titleLabel?.font = Styles.Fonts.bodyBold
        actorButton.setTitleColor(Styles.Colors.Gray.dark.color, for: .normal)
        actorButton.addTarget(self, action: #selector(IssueMergedCell.onActor), for: .touchUpInside)
        contentView.addSubview(actorButton)
        actorButton.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.centerY.equalTo(contentView)
        }

        mergedButton.setTitle(Strings.merged, for: .normal)
        mergedButton.setupAsLabel()
        mergedButton.config(pullRequest: false, state: .merged)
        contentView.addSubview(mergedButton)
        mergedButton.snp.makeConstraints { make in
            make.left.equalTo(actorButton.snp.right).offset(Styles.Sizes.inlineSpacing)
            make.centerY.equalTo(contentView)
        }

        hashButton.titleLabel?.font = UIFont(name: "Courier-Bold", size: Styles.Sizes.Text.body)
        hashButton.setTitleColor(Styles.Colors.Gray.dark.color, for: .normal)
        hashButton.addTarget(self, action: #selector(IssueMergedCell.onHash), for: .touchUpInside)
        contentView.addSubview(hashButton)
        hashButton.snp.makeConstraints { make in
            make.left.equalTo(mergedButton.snp.right).offset(Styles.Sizes.inlineSpacing)
            make.centerY.equalTo(contentView)
        }

        dateLabel.font = Styles.Fonts.body
        dateLabel.textColor = Styles.Colors.Gray.medium.color
        dateLabel.backgroundColor = .clear
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(hashButton.snp.right).offset(Styles.Sizes.inlineSpacing)
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

    func onHash() {
        delegate?.didTapHash(cell: self)
    }

    // MARK: Public API

    func configure(viewModel: IssueMergedModel) {
        actorButton.setTitle(viewModel.actor, for: .normal)
        dateLabel.setText(date: viewModel.date)
        hashButton.setTitle(viewModel.commitHash.hashDisplay, for: .normal)
    }
}
