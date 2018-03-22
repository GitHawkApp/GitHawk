//
//  IssueMilestoneEventCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import SnapKit

final class IssueMilestoneEventCell: StyledTextViewCell {

    // MARK: Public API

    func configure(_ model: IssueMilestoneEventModel) {
        set(renderer: model.string)
    }

}
