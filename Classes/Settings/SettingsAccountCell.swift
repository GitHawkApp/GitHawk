//
//  SettingsAccountCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/29/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

protocol SettingsAccountCellDelegate: class {
    func didTapPAT(for cell: SettingsAccountCell)
}

final class SettingsAccountCell: StyledTableCell {

    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var patButton: UIButton!

    private weak var delegate: SettingsAccountCellDelegate?

    @IBAction func onPAT(_ sender: Any) {
        delegate?.didTapPAT(for: self)
    }

    func configure(
        with username: String,
        delegate: SettingsAccountCellDelegate,
        hasPAT: Bool,
        isCurrentUser: Bool
        ) {
        usernameLabel.text = username
        self.delegate = delegate
        patButton.setImage(
            UIImage(named: hasPAT ? "pencil-small" : "plus-small")?.withRenderingMode(.alwaysTemplate),
            for: .normal
        )
        accessoryType = isCurrentUser ? .checkmark : .none
    }

}
