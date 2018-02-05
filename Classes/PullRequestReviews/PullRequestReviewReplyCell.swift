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

        let color = Styles.Colors.Blue.medium.color
        button.setTitle(NSLocalizedString("Reply", comment: ""), for: .normal)
        button.setImage(UIImage(named: "reply")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = color
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = Styles.Text.body.preferredFont
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
