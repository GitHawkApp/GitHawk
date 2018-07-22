//
//  LabelListCell.swift
//  Freetime
//
//  Created by Joe Rocca on 12/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class LabelListCell: UICollectionViewCell, ListBindable {
    
    static let reuse = "cell"
    static let font = Styles.Text.smallTitle.preferredFont

    static func size(_ string: String) -> CGSize {
        return (string as NSString).size(withAttributes: [
            .font: font
            ]).resized(inset: UIEdgeInsets(
                top: 3,
                left: Styles.Sizes.labelTextPadding,
                bottom: 3,
                right: Styles.Sizes.labelTextPadding)
        )
    }
    
    private let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        isAccessibilityElement = true
        accessibilityTraits |= UIAccessibilityTraitButton
        
        layer.cornerRadius = Styles.Sizes.labelCornerRadius
        contentView.layer.cornerRadius = Styles.Sizes.labelCornerRadius
        
        nameLabel.font = LabelListCell.font
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? RepositoryLabel else { return }
        let color = UIColor.fromHex(viewModel.color)
        contentView.backgroundColor = color
        nameLabel.text = viewModel.name
        nameLabel.textColor = color.textOverlayColor
    }
    
    // MARK: Public API
    
    func configure(label: RepositoryLabel) {
        let color = UIColor.fromHex(label.color)
        backgroundColor = color
        nameLabel.text = label.name
        nameLabel.textColor = color.textOverlayColor
    }

    // MARK: Accessibility

    override var accessibilityLabel: String? {
        get {
            return AccessibilityHelper.generatedLabel(forCell: self)
        }
        set { }
    }
    
}
