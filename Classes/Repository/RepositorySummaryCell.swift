//
//  RepositorySummaryCell.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class RepositorySummaryCell: UICollectionViewCell {
    
    static let labelInset = UIEdgeInsets(
        top: Styles.Fonts.title.lineHeight + Styles.Fonts.secondary.lineHeight + 3*Styles.Sizes.rowSpacing,
        left: Styles.Sizes.icon.width + 2*Styles.Sizes.columnSpacing,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter
    )
    
    private let reasonImageView = UIImageView()
    private let titleLabel = UILabel()
    private let secondaryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true
        
        contentView.backgroundColor = .white
        
        titleLabel.numberOfLines = 1
        titleLabel.font = Styles.Fonts.title
        titleLabel.textColor = Styles.Colors.Gray.dark.color
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(Styles.Sizes.rowSpacing)
            make.left.equalTo(SearchResultCell.labelInset.left)
        }
        
        reasonImageView.backgroundColor = .clear
        reasonImageView.contentMode = .scaleAspectFit
        reasonImageView.tintColor = Styles.Colors.Blue.medium.color
        contentView.addSubview(reasonImageView)
        reasonImageView.snp.makeConstraints { make in
            make.size.equalTo(Styles.Sizes.icon)
            make.top.equalTo(RepositorySummaryCell.labelInset.top)
            make.left.equalTo(Styles.Sizes.rowSpacing)
        }
        
        secondaryLabel.numberOfLines = 1
        secondaryLabel.font = Styles.Fonts.secondary
        secondaryLabel.textColor = Styles.Colors.Gray.light.color
        contentView.addSubview(secondaryLabel)
        secondaryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Styles.Sizes.rowSpacing)
            make.left.equalTo(RepositorySummaryCell.labelInset.left)
        }
                
        addBorder(.bottom, left: SearchResultCell.labelInset.left)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(result: IssueSummaryType) {
        titleLabel.text = result.title
        secondaryLabel.text = "#\(result.number) opened \(result.createdAt?.agoString ?? "") by \(result.author ?? Strings.unknown)"
        reasonImageView.image = NotificationType.issue.icon
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
