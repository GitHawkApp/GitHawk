//
//  StyledSwitch.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/11/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

class StyledSwitch: UISwitch {

    override func awakeFromNib() {
        super.awakeFromNib()
        onTintColor = Styles.Colors.Green.medium.color
    }

}
