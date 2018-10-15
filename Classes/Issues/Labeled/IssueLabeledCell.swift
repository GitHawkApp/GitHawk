//
//  IssueLabeledCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueLabeledCell: StyledTextViewCell {

    static let insets = UIEdgeInsets(
        top: Styles.Sizes.inlineSpacing,
        left: 0,
        bottom: Styles.Sizes.inlineSpacing,
        right: 0
    )

    // MARK: Public API

    func configure(_ model: IssueLabeledModel) {
        set(renderer: model.string)
    }

}
