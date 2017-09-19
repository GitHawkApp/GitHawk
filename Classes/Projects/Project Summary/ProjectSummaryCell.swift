//
//  ProjectSummaryCell.swift
//  Freetime
//
//  Created by Sherlock, James on 19/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class ProjectSummaryCell: SelectableCell {
    
    static let descriptionInset = UIEdgeInsets(
        top: Styles.Fonts.body.lineHeight + Styles.Sizes.gutter + Styles.Sizes.rowSpacing,
        left: Styles.Sizes.gutter,
        bottom: Styles.Sizes.gutter,
        right: Styles.Sizes.gutter
    )
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    static let descriptionAttributes = [
        NSFontAttributeName: Styles.Fonts.secondary,
        NSForegroundColorAttributeName: Styles.Colors.Gray.light.color
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true
        
        contentView.backgroundColor = .white
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        titleLabel.textColor = Styles.Colors.Gray.dark.color
        titleLabel.font = Styles.Fonts.body
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(Styles.Sizes.gutter)
            make.left.equalTo(ProjectSummaryCell.descriptionInset.left)
            make.right.equalTo(ProjectSummaryCell.descriptionInset.right)
        }
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(ProjectSummaryCell.descriptionInset).priority(900)
        }
        
        addBorder(.bottom, left: ProjectSummaryCell.descriptionInset.left)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public API
    
    func configure(_ model: Project) {
        titleLabel.text = model.name
        descriptionLabel.attributedText = model.body?.attributedText
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
