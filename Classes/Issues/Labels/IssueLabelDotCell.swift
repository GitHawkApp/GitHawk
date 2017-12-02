//
//  IssueLabelDotCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class IssueLabelDotCell: UICollectionViewCell {

    static let reuse = "cell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = Styles.Colors.Gray.border.color.cgColor
        layer.borderWidth = 1 / UIScreen.main.scale
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width/2
    }

}
