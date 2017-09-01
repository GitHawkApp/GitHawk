//
//  LabelTableCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class LabelTableCell: StyledTableCell {

    @IBOutlet weak var button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        button.layer.cornerRadius = Styles.Sizes.avatarCornerRadius
        button.layer.borderColor = Styles.Colors.Gray.border.color.cgColor
        button.layer.borderWidth = 1 / UIScreen.main.scale
        button.clipsToBounds = true
        button.isUserInteractionEnabled = false
        button.contentEdgeInsets = UIEdgeInsets(
            top: Styles.Sizes.inlineSpacing,
            left: Styles.Sizes.columnSpacing,
            bottom: Styles.Sizes.inlineSpacing,
            right: Styles.Sizes.columnSpacing
        )
    }

    // MARK: Public API

    func configure(label: String, color: UIColor, selected: Bool) {
        button.setTitle(label, for: .normal)
        button.setTitleColor(color.textOverlayColor, for: .normal)
        button.backgroundColor = color
        accessoryType = selected ? .checkmark : .none
    }

}
