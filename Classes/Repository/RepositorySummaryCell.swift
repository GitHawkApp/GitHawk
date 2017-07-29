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
        top: Styles.Sizes.rowSpacing,
        left: Styles.Sizes.icon.width + 2*Styles.Sizes.columnSpacing,
        bottom: Styles.Fonts.secondary.lineHeight + 2*Styles.Sizes.rowSpacing,
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
        
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(Styles.Sizes.rowSpacing)
            make.left.equalTo(RepositorySummaryCell.labelInset.left)
            make.right.equalTo(RepositorySummaryCell.labelInset.right)
        }
        
        reasonImageView.backgroundColor = .clear
        reasonImageView.contentMode = .scaleAspectFit
        reasonImageView.tintColor = Styles.Colors.Blue.medium.color
        contentView.addSubview(reasonImageView)
        reasonImageView.snp.makeConstraints { make in
            make.size.equalTo(Styles.Sizes.icon)
            make.centerY.equalToSuperview()
            make.left.equalTo(Styles.Sizes.columnSpacing)
        }
        
        secondaryLabel.numberOfLines = 1
        secondaryLabel.font = Styles.Fonts.secondary
        secondaryLabel.textColor = Styles.Colors.Gray.light.color
        contentView.addSubview(secondaryLabel)
        secondaryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Styles.Sizes.rowSpacing)
            make.left.equalTo(RepositorySummaryCell.labelInset.left)
            make.right.equalTo(RepositorySummaryCell.labelInset.right)
        }
                
        addBorder(.bottom, left: RepositorySummaryCell.labelInset.left)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(result: IssueSummaryType) {
        titleLabel.attributedText = result.attributedTitle.attributedText
        secondaryLabel.text = "#\(result.number) opened \(result.createdAtDate?.agoString ?? "") by \(result.authorName ?? Strings.unknown)"
        
        // This all needs to be tidied up
        if result.isIssue {
            reasonImageView.image = NotificationType.issue.icon?.withRenderingMode(.alwaysTemplate)
            reasonImageView.tintColor = result.rawState == IssueState.open.rawValue ? "#28a745".color : "#cb2431".color
        } else {
            reasonImageView.image = NotificationType.pullRequest.icon?.withRenderingMode(.alwaysTemplate)
            switch result.rawState {
            case PullRequestState.open.rawValue:
                reasonImageView.tintColor = "#28a745".color
            case PullRequestState.closed.rawValue:
                reasonImageView.tintColor = "#cb2431".color
            case PullRequestState.merged.rawValue:
                reasonImageView.tintColor = "#6f42c1".color
            default:
                break
            }
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
