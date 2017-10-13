//
//  AutocompleteCell.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 7/23/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

final class AutocompleteCell: StyledTableCell {

    enum State {
        case emoji(emoji: String, term: String)
        case user(avatarURL: URL, login: String)
    }

    private let thumbnailImageView = UIImageView()
    private let emojiLabel = UILabel()
    private let titleLabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.backgroundColor = Styles.Colors.Gray.lighter.color
        thumbnailImageView.layer.cornerRadius = Styles.Sizes.avatarCornerRadius
        thumbnailImageView.layer.borderColor = Styles.Colors.Gray.light.color.cgColor
        thumbnailImageView.layer.borderWidth = 1.0 / UIScreen.main.scale
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.isUserInteractionEnabled = true
        contentView.addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.size.equalTo(Styles.Sizes.avatar)
            make.centerY.equalTo(contentView)
        }

        emojiLabel.font = UIFont.systemFont(ofSize: 20)
        contentView.addSubview(emojiLabel)
        emojiLabel.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.size.equalTo(Styles.Sizes.avatar)
            make.centerY.equalTo(contentView)
        }

        titleLabel.font = Styles.Fonts.body
        titleLabel.textColor = Styles.Colors.Gray.dark.color
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter + Styles.Sizes.avatar.width + Styles.Sizes.columnSpacing)
            make.centerY.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(state: State) {

        let emojiHidden: Bool
        let thumbnailHidden: Bool
        let title: String

        switch state {
        case .emoji(let emoji, let term):
            emojiHidden = false
            thumbnailHidden = true
            emojiLabel.text = emoji
            title = term
        case .user(let avatarURL, let login):
            emojiHidden = true
            thumbnailHidden = false
            thumbnailImageView.sd_setImage(with: avatarURL)
            title = login
        }

        emojiLabel.isHidden = emojiHidden
        thumbnailImageView.isHidden = thumbnailHidden
        titleLabel.text = title
    }

}
