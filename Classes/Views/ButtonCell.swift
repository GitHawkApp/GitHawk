//
//  ButtonCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class ButtonCell: SelectableCell {

    let label = UILabel()

    private let disclosureImageView = UIImageView()
    private var topSeparator: UIView? = nil
    private var bottomSeparator: UIView? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white
        accessibilityTraits |= UIAccessibilityTraitButton

        topSeparator = contentView.addBorder(.top)
        bottomSeparator = contentView.addBorder(.bottom)

        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = Styles.Fonts.button
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.gutter)
        }

        disclosureImageView.image = UIImage(named: "chevron-right")?.withRenderingMode(.alwaysTemplate)
        disclosureImageView.tintColor = Styles.Colors.Gray.light.color
        contentView.addSubview(disclosureImageView)
        disclosureImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(-Styles.Sizes.gutter)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(
        disclosureHidden: Bool = true,
        topSeparatorHidden: Bool = false,
        bottomSeparatorHidden: Bool = false
        ) {
        disclosureImageView.isHidden = disclosureHidden
        topSeparator?.isHidden = topSeparatorHidden
        bottomSeparator?.isHidden = bottomSeparatorHidden
    }

}
