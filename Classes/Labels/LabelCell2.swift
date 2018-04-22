//
//  LabelCell2.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/21/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

final class LabelCell2: SelectableCell, ListSwiftBindable {

    private let button = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        isAccessibilityElement = true
        accessibilityTraits |= UIAccessibilityTraitButton

        contentView.addSubview(button)
        button.titleLabel?.font = Styles.Text.secondaryBold.preferredFont
        button.layer.cornerRadius = Styles.Sizes.avatarCornerRadius
        button.layer.borderColor = Styles.Colors.Gray.border.color.cgColor
        button.layer.borderWidth = 1 / UIScreen.main.scale
        button.clipsToBounds = true
        button.isUserInteractionEnabled = false
        button.contentEdgeInsets = UIEdgeInsets(
            top: Styles.Sizes.inlineSpacing,
            left: Styles.Sizes.columnSpacing,
            bottom: Styles.Sizes.inlineSpacing,
            right: Styles.Sizes.columnSpacing
        )
        button.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.centerY.equalToSuperview()
        }

        contentView.addBorder(.bottom, left: Styles.Sizes.gutter, right: -Styles.Sizes.gutter)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ListSwiftBindable

    func bind(value: ListSwiftDiffable) {
        guard let value = value as? RepositoryLabel else { return }
        button.setTitle(value.name, for: .normal)

        let color = value.color.color
        button.setTitleColor(color.textOverlayColor, for: .normal)
        button.backgroundColor = color
    }

}
