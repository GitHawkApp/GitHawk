//
//  PeopleCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SDWebImage

final class PeopleCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.configureForAvatar()
    }

    // MARK: Public API

    func configure(avatarURL: URL, username: String, showCheckmark: Bool) {
        avatarImageView.sd_setImage(with: avatarURL)
        usernameLabel.text = username
        accessoryType = showCheckmark ? .checkmark : .none
    }
    
}
