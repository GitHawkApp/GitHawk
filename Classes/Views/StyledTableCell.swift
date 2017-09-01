//
//  StyledTableCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

class StyledTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()

        let background = UIView()
        background.backgroundColor = Styles.Colors.Gray.alphaLighter
        selectedBackgroundView = background
    }

}
