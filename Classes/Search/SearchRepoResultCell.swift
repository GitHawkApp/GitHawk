//
//  SearchRepoResultCell.swift
//  Freetime
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class SearchRepoResultCell: SelectableCell {

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
    private let starsLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true

        backgroundColor = .white

        contentView.addSubview(titleLabel)
        contentView.addSubview(languageLabel)
        contentView.addSubview(languageColorView)
        contentView.addSubview(starsLabel)
        contentView.addSubview(descriptionLabel)

        titleLabel.textColor = Styles.Colors.Gray.dark.color
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(Styles.Sizes.rowSpacing)
            make.left.equalTo(SearchRepoResultCell.labelInset.left)
            make.right.lessThanOrEqualTo(languageColorView.snp.left).offset(-Styles.Sizes.rowSpacing)
        }

        // always collapse and truncate the title
        titleLabel.lineBreakMode = .byTruncatingMiddle
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)

        languageLabel.font = Styles.Fonts.secondary
        languageLabel.textColor = Styles.Colors.Gray.light.color
        languageLabel.snp.makeConstraints { make in
            make.right.equalTo(-Styles.Sizes.gutter)
            make.centerY.equalTo(titleLabel)
        }

        let languageColorWidth: CGFloat = 8
        languageColorView.layer.cornerRadius = languageColorWidth / 2
        languageColorView.snp.makeConstraints { make in
            make.right.equalTo(languageLabel.snp.left).offset(-Styles.Sizes.columnSpacing/2)
            make.centerY.equalTo(languageLabel)
            make.width.equalTo(languageColorWidth)
            make.height.equalTo(languageColorWidth)
        }

        starsLabel.font = Styles.Fonts.secondary
        starsLabel.textColor = Styles.Colors.Gray.light.color
        starsLabel.snp.makeConstraints { make in
            make.right.equalTo(-Styles.Sizes.gutter)
            make.top.equalTo(titleLabel.snp.bottom).offset(Styles.Sizes.rowSpacing)
            make.right.equalTo(languageLabel)
        }

        descriptionLabel.font = Styles.Fonts.secondary
        descriptionLabel.textColor = Styles.Colors.Gray.light.color
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(starsLabel)
            make.right.lessThanOrEqualTo(starsLabel.snp.left).offset(-Styles.Sizes.columnSpacing)
            make.left.equalTo(titleLabel)
        }

        addBorder(.bottom, left: SearchRepoResultCell.labelInset.left)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(result: SearchRepoResult) {
        titleLabel.attributedText = RepositoryAttributedString(owner: result.owner, name: result.name)

        descriptionLabel.text = result.description

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

        let starsCount = NumberFormatter.localizedString(from: NSNumber(value: result.stars), number: .decimal)
        starsLabel.text = "\u{2605}\(starsCount)"
    }

    override var accessibilityLabel: String? {
        get {
            return AccessibilityHelper.generatedLabel(forCell: self)
        }
        set { }
    }

}
