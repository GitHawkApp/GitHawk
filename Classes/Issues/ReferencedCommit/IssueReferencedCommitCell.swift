//
//  IssueReferencedCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueReferencedCommitCell: StyledTextViewCell {

    // MARK: Public API

    func configure(_ model: IssueReferencedCommitModel) {
        set(renderer: model.string)
    }

}
