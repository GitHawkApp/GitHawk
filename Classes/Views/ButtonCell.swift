//
//  ButtonCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class ButtonCell: UICollectionViewCell {

    let label = UILabel()

    private var topSeparator: UIView? = nil
    private var bottomSeparator: UIView? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white
        accessibilityTraits |= UIAccessibilityTraitButton

        topSeparator = contentView.addBorder(bottom: false, left: 0, right: 0)
        bottomSeparator = contentView.addBorder(bottom: true, left: 0, right: 0)

        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = Styles.Fonts.button
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.gutter)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(topSeparatorHidden: Bool = false, bottomSeparatorHidden: Bool = false) {
        topSeparator?.isHidden = topSeparatorHidden
        bottomSeparator?.isHidden = bottomSeparatorHidden
    }

}
