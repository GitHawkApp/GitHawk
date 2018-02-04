//
//  PullRequestReviewReplyCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 1/29/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class PullRequestReviewReplyCell: IssueCommentBaseCell {

    private let button = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        isAccessibilityElement = true
        accessibilityTraits |= UIAccessibilityTraitButton

        let buttonTitle = NSLocalizedString("Reply", comment: "")
        accessibilityLabel = buttonTitle

        let color = Styles.Colors.Blue.medium.color
        button.setTitle(buttonTitle, for: .normal)
        button.setImage(UIImage(named: "reply")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = color
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = Styles.Fonts.body
        button.isUserInteractionEnabled = false

        let spacing = Styles.Sizes.columnSpacing / 2
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing, bottom: 0, right: spacing)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: -spacing)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)

        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        border = .tail
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
