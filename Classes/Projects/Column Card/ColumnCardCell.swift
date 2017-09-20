//
//  ColumnCardCell.swift
//  Freetime
//
//  Created by Sherlock, James on 20/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class ColumnCardCell: SelectableCell {
    
    static let titleInset = UIEdgeInsets(
        top: Styles.Sizes.gutter,
        left: (Styles.Sizes.columnSpacing * 2) + Styles.Sizes.icon.width,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter
    )
    
    static let infoInset = UIEdgeInsets(
        top: 0,
        left: ColumnCardCell.titleInset.left,
        bottom: Styles.Sizes.gutter,
        right: ColumnCardCell.titleInset.right
    )
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let infoContainer = UIView()
    private let infoLabel = AttributedStringView()
    
    static let titleAttributes = [
        NSFontAttributeName: Styles.Fonts.body,
        NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color
    ]
    
    static let infoAttributes = [
        NSFontAttributeName: Styles.Fonts.secondary,
        NSForegroundColorAttributeName: Styles.Colors.Gray.light.color
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true
        
        contentView.backgroundColor = .white
        
        let inset = ColumnCardCell.titleInset
        
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(inset.top)
            make.left.equalTo(contentView).offset(inset.left)
            make.right.equalTo(contentView).offset(-inset.right)
        }
        
        iconImageView.backgroundColor = .clear
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = Styles.Colors.Blue.medium.color
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(Styles.Sizes.icon)
            make.left.equalTo(Styles.Sizes.columnSpacing)
            make.top.equalTo(Styles.Sizes.gutter)
        }
        
        contentView.addSubview(infoContainer)
        infoContainer.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(inset.bottom)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
        
        infoContainer.addSubview(infoLabel)
        
        contentView.addBorder(.bottom)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        infoLabel.reposition(width: contentView.bounds.width)
    }
    
    // MARK: Public API
    
    func configure(_ model: Project.Details.Column.Card) {
        titleLabel.attributedText = model.title.attributedText
        iconImageView.image = model.type.style.image?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = model.type.style.color
        infoLabel.configureAndSizeToFit(text: model.description, width: contentView.bounds.width)
    }
    
    override var accessibilityLabel: String? {
        get {
            return contentView.subviews
                .flatMap { $0.accessibilityLabel }
                .reduce("", { $0 + ".\n" + $1 })
        }
        set { }
    }
    
}
