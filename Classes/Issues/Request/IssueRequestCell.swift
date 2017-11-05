//
//  IssueRequestCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueRequestCell: AttributedStringCell {

    // MARK: Public API

    func configure(_ model: IssueRequestModel) {
        set(attributedText: model.attributedText)
    }

}
