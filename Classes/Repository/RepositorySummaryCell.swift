//
//  RepositorySummaryCell.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class RepositorySummaryCell: SelectableCell {
    
    static let titleInset = UIEdgeInsets(
        top: Styles.Sizes.rowSpacing,
        left: Styles.Sizes.icon.width + 2*Styles.Sizes.columnSpacing,
        bottom: Styles.Fonts.secondary.lineHeight + 2*Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter
    )
    
    private let reasonImageView = UIImageView()
    private let titleView = AttributedStringView()
    private let secondaryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true
        
        contentView.backgroundColor = .white

        contentView.addSubview(titleView)
        
        reasonImageView.backgroundColor = .clear
        reasonImageView.contentMode = .scaleAspectFit
        reasonImageView.tintColor = Styles.Colors.Blue.medium.color
        contentView.addSubview(reasonImageView)
        reasonImageView.snp.makeConstraints { make in
            make.size.equalTo(Styles.Sizes.icon)
            make.centerY.equalToSuperview()
            make.left.equalTo(Styles.Sizes.columnSpacing)
        }

        let inset = RepositorySummaryCell.titleInset
        
        secondaryLabel.numberOfLines = 1
        secondaryLabel.font = Styles.Fonts.secondary
        secondaryLabel.textColor = Styles.Colors.Gray.light.color
        contentView.addSubview(secondaryLabel)
        secondaryLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).offset(-Styles.Sizes.rowSpacing)
            make.left.equalTo(inset.left)
            make.right.equalTo(-inset.right)
        }
                
        contentView.addBorder(.bottom, left: inset.left)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleView.reposition(width: contentView.bounds.width)
    }

    // MARK: Public API
    
    func configure(_ model: RepositoryIssueSummaryModel) {
        titleView.configureAndSizeToFit(text: model.title, width: contentView.bounds.width)
        
        let format = NSLocalizedString("#%d opened %@ by %@", comment: "")
        secondaryLabel.text = String.localizedStringWithFormat(format, model.number, model.created.agoString, model.author)

        let imageName: String
        let tint: UIColor
        switch model.status {
        case .closed:
            imageName = model.pullRequest ? "git-pull-request" : "issue-closed"
            tint = Styles.Colors.Red.medium.color
        case .open:
            imageName = model.pullRequest ? "git-pull-request" : "issue-opened"
            tint = Styles.Colors.Green.medium.color
        case .merged:
            imageName = "git-merge"
            tint = Styles.Colors.purple.color
        }

        reasonImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        reasonImageView.tintColor = tint
    }
    
    override var accessibilityLabel: String? {
        get {
            return contentView.subviews
                .flatMap { $0.accessibilityLabel }
                .reduce("", { "\($0 ?? "").\n\($1)" })
        }
        set { }
    }
    
}
