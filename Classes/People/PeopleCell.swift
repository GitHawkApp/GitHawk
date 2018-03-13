//
//  PeopleCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

final class PeopleCell: UICollectionViewCell {

    let avatarImageView = UIImageView()
    let usernameLabel = UILabel()
    let checkmarkImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(checkmarkImageView)

        avatarImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(Styles.Sizes.gutter)
            make.size.equalTo(Styles.Sizes.avatar)
        }

        usernameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(avatarImageView.snp.right).offset(Styles.Sizes.gutter)
        }

        checkmarkImageView.image = UIImage(named: "check")?.withRenderingMode(.alwaysTemplate)
        checkmarkImageView.tintColor = Styles.Colors.Blue.medium.color
        checkmarkImageView.contentMode = .scaleAspectFit

        checkmarkImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(-Styles.Sizes.gutter)
            make.size.equalTo(Styles.Sizes.icon)
        }

        avatarImageView.configureForAvatar()

        contentView.addBorder(.bottom, left: Styles.Sizes.gutter, right: -Styles.Sizes.gutter)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(avatarURL: URL, username: String, showCheckmark: Bool) {
        avatarImageView.sd_setImage(with: avatarURL)
        usernameLabel.text = username
        setCellState(selected: showCheckmark)
    }

    func setCellState(selected: Bool) {
        checkmarkImageView.isHidden = !selected
    }
}
