//
//  IssueManagingExpansionCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

final class IssueManagingExpansionCell: UICollectionViewCell, ListBindable {

    private let label = UILabel()
    private let chevron = UIImageView(image: UIImage(named: "chevron-down-small")?.withRenderingMode(.alwaysTemplate))

    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true
        
        let tint = Styles.Colors.Blue.medium.color

        chevron.tintColor = tint
        contentView.addSubview(chevron)
        chevron.snp.makeConstraints { make in
            make.centerY.equalTo(contentView).offset(1)
            make.right.equalTo(contentView).offset(-Styles.Sizes.gutter)
        }

        label.text = NSLocalizedString("Manage", comment: "")
        label.font = Styles.Text.secondaryBold.preferredFont
        label.textColor = tint
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(chevron.snp.left).offset(-Styles.Sizes.rowSpacing+3)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
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
        chevron.alpha = alpha
    }
    
    // MARK: Public API

    func animate(expanded: Bool) {
        UIView.animate(
            withDuration: (0.8),
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0,
            options: [],
            animations: {
                self.rotateChevron(expanded: expanded)
        })
    }

    // MARK: Private API

    private func rotateChevron(expanded: Bool) {
        // nudging the angles let's us control the animation direction
        chevron.transform = expanded
            ? CGAffineTransform(rotationAngle: CGFloat.pi + 0.00001)
            : CGAffineTransform(rotationAngle: -0.00001)
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueManagingExpansionModel else { return }
        rotateChevron(expanded: viewModel.expanded)
    }

    // MARK: Accessibility
    override var accessibilityLabel: String? {
        get {
            return AccessibilityHelper.generatedLabel(forCell: self)
        }
        set { }
    }
}
