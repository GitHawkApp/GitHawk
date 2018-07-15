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

final class PeopleCell: SelectableCell {

    private let avatarImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let checkmarkImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = nil
        contentView.backgroundColor = nil
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(checkmarkImageView)

        avatarImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(Styles.Sizes.gutter)
            make.size.equalTo(Styles.Sizes.avatar)
        }

        usernameLabel.font = Styles.Text.bodyBold.preferredFont
        usernameLabel.textColor = .white
        usernameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(avatarImageView.snp.right).offset(Styles.Sizes.gutter)
        }

        checkmarkImageView.image = UIImage(named: "check-small")?.withRenderingMode(.alwaysTemplate)
        checkmarkImageView.tintColor = Styles.Colors.Blue.medium.color
        checkmarkImageView.contentMode = .scaleAspectFit

        checkmarkImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(-Styles.Sizes.gutter)
            make.size.equalTo(Styles.Sizes.icon)
        }

        avatarImageView.configureForAvatar(border: false)

        let border = contentView.addBorder(.bottom, left: Styles.Sizes.gutter, right: -Styles.Sizes.gutter)
        border.backgroundColor = Styles.Colors.Gray.medium.color
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
