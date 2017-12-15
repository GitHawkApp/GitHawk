//
//  SettingsLabel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class SettingsLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    func configure() {
        font = Styles.Fonts.body
    }

}
