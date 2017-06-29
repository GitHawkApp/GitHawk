//
//  IssueMergedCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/29/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

final class IssueMergedCell: UICollectionViewCell, ListBindable {

    let actorLabel = UILabel()
    let hashLabel = UILabel()
    let button = UIButton()
    let dateLabel = ShowMoreDetailsLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        actorLabel.font = Styles.Fonts.bodyBold
        actorLabel.textColor = Styles.Colors.Gray.dark.color
        actorLabel.backgroundColor = .clear
        contentView.addSubview(actorLabel)
        actorLabel.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.centerY.equalTo(contentView)
        }

        button.setTitle(Strings.merged, for: .normal)
        button.setImage(UIImage(named: "git-merged-small"), for: .normal)
        button.backgroundColor = Styles.Colors.purple.color
        button.setupAsLabel()
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.left.equalTo(actorLabel.snp.right).offset(Styles.Sizes.inlineSpacing)
            make.centerY.equalTo(contentView)
        }

        hashLabel.font = UIFont(name: "Courier-Bold", size: Styles.Sizes.Text.body)
        hashLabel.backgroundColor = .clear
        hashLabel.textColor = Styles.Colors.Gray.dark.color
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

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueMergedModel else { return }

        actorLabel.text = viewModel.actor
        dateLabel.setText(date: viewModel.date)

        // trim to first <7 characters
        let hash = viewModel.commitHash
        hashLabel.text = hash.substring(with: NSRange(location: 0, length: min(hash.nsrange.length, 7)))
    }
}
