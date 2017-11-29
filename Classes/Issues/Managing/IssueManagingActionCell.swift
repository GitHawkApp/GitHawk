//
//  IssueManagingActionCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

final class IssueManagingActionCell: UICollectionViewCell, ListBindable {

    private let label = UILabel()
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true

        let tint = Styles.Colors.Blue.medium.color

        imageView.tintColor = tint
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(Styles.Sizes.buttonIcon)
            make.centerX.equalTo(contentView)
            make.centerY.equalTo(contentView).offset(-7)
        }

        label.textColor = tint
        label.font = Styles.Fonts.secondary
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isSelected: Bool {
        didSet {
            highlight(isSelected)
        }
    }

    override var isHighlighted: Bool {
        didSet {
            highlight(isHighlighted)
        }
    }

    // MARK: Private API

    func highlight(_ highlight: Bool) {
        let alpha: CGFloat = highlight ? 0.5 : 1
        label.alpha = alpha
        imageView.alpha = alpha
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueManagingActionModel else { return }
        label.text = viewModel.label
        imageView.image = UIImage(named: viewModel.imageName)?.withRenderingMode(.alwaysTemplate)
    }

    // MARK: Accessibility
    override var accessibilityLabel: String? {
        get {
            return AccessibilityHelper.generatedLabel(forCell: self)
        }
        set { }
    }
}
