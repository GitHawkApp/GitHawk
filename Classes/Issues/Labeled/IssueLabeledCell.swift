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
        left: Styles.Sizes.eventGutter,
        bottom: Styles.Sizes.inlineSpacing,
        right: Styles.Sizes.eventGutter
    )
    
    // MARK: Public API

    func configure(_ model: IssueLabeledModel) {
        set(renderer: model.string)
    }

}
