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
    
    private let closedIndicator = UIButton()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private var closedIndicatorToTitleConstraint: Constraint?
    
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
        contentView.addSubview(closedIndicator)
        
        closedIndicator.titleLabel?.font = Styles.Fonts.secondary
        closedIndicator.setTitleColor(Styles.Colors.Red.medium.color, for: .normal)
        closedIndicator.layer.borderColor = Styles.Colors.Red.medium.color.cgColor
        closedIndicator.layer.borderWidth = 1
        closedIndicator.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, for: .horizontal)
        closedIndicator.contentEdgeInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        closedIndicator.layer.cornerRadius = 3
        closedIndicator.snp.makeConstraints { make in
            make.top.equalTo(Styles.Sizes.gutter)
            make.left.equalTo(ProjectSummaryCell.descriptionInset.left)
        }
        
        titleLabel.textColor = Styles.Colors.Gray.dark.color
        titleLabel.font = Styles.Fonts.body
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(Styles.Sizes.gutter)
            make.left.equalTo(ProjectSummaryCell.descriptionInset.left).priority(500)
            self.closedIndicatorToTitleConstraint = make.left.equalTo(closedIndicator.snp.right).offset(Styles.Sizes.columnSpacing).constraint
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
        closedIndicator.setTitle(model.isClosed ? Strings.closed : nil, for: .normal)
        closedIndicator.isHidden = !model.isClosed
        
        let gray = Styles.Colors.Gray.self
        titleLabel.textColor = model.isClosed ? gray.light.color : gray.dark.color
        
        if model.isClosed {
            closedIndicatorToTitleConstraint?.activate()
        } else {
            closedIndicatorToTitleConstraint?.deactivate()
        }
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
