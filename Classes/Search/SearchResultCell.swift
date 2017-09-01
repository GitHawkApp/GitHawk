//
//  SearchResultCell.swift
//  Freetime
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class SearchResultCell: UICollectionViewCell {

    static let labelInset = UIEdgeInsets(
        top: Styles.Fonts.title.lineHeight + Styles.Fonts.secondary.lineHeight + 3*Styles.Sizes.rowSpacing,
        left: Styles.Sizes.gutter,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter
    )
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let languageLabel = UILabel()
    private let languageColorView = UIView()
    private let dateLabel = ShowMoreDetailsLabel()
    private let starsLabel = UILabel()
    
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
        
        languageLabel.numberOfLines = 1
        languageLabel.font = Styles.Fonts.secondary
        languageLabel.textColor = Styles.Colors.Gray.light.color
        languageLabel.textAlignment = .right
        contentView.addSubview(languageLabel)
        languageLabel.snp.makeConstraints { make in
            make.right.equalTo(-Styles.Sizes.gutter)
            make.centerY.equalTo(titleLabel)
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(Styles.Sizes.gutter)
        }
        
        let languageColorWidth: CGFloat = 8
        languageColorView.layer.cornerRadius = languageColorWidth / 2
        contentView.addSubview(languageColorView)
        languageColorView.snp.makeConstraints { make in
            make.right.equalTo(languageLabel.snp.left).offset(-Styles.Sizes.columnSpacing)
            make.centerY.equalTo(languageLabel)
            make.height.equalTo(languageColorView.snp.width)
            make.height.equalTo(languageColorWidth)
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(Styles.Sizes.gutter)
        }
        
        dateLabel.numberOfLines = 1
        dateLabel.font = Styles.Fonts.secondary
        dateLabel.textColor = Styles.Colors.Gray.light.color
        dateLabel.textAlignment = .left
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Styles.Sizes.rowSpacing)
            make.left.equalTo(SearchResultCell.labelInset.left)
        }
        
        starsLabel.numberOfLines = 1
        starsLabel.font = Styles.Fonts.secondary
        starsLabel.textColor = Styles.Colors.Gray.light.color
        starsLabel.textAlignment = .right
        contentView.addSubview(starsLabel)
        starsLabel.snp.makeConstraints { make in
            make.right.equalTo(-Styles.Sizes.gutter)
            make.centerY.equalTo(dateLabel)
            make.left.greaterThanOrEqualTo(dateLabel.snp.right).offset(Styles.Sizes.gutter)
        }
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = Styles.Fonts.secondary
        descriptionLabel.textColor = Styles.Colors.Gray.dark.color
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(SearchResultCell.labelInset)
        }
        
        addBorder(.bottom, left: SearchResultCell.labelInset.left)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(result: SearchResult) {
        titleLabel.text = result.nameWithOwner
        descriptionLabel.attributedText = result.description?.attributedText
        
        if let primaryLanguage = result.primaryLanguage {
            languageLabel.isHidden = false
            languageLabel.text = primaryLanguage.name
            
            if let color = result.primaryLanguage?.color {
                languageColorView.isHidden = false
                languageColorView.backgroundColor = color
            } else {
                languageColorView.isHidden = true
            }
        } else {
            languageLabel.isHidden = true
            languageColorView.isHidden = true
        }
        
        if let pushedAt = result.pushedAt {
            dateLabel.isHidden = false
            
            let format = NSLocalizedString("Updated %@", comment: "")
            dateLabel.text = String.localizedStringWithFormat(format, pushedAt.agoString)
            dateLabel.detailText = DateDetailsFormatter().string(from: pushedAt)
        } else {
            dateLabel.isHidden = true
        }
        
        let starsCount = NumberFormatter.localizedString(from: NSNumber(value: result.stars), number: .decimal)
        starsLabel.text = "\u{2605} \(starsCount)"
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
