//
//  IssueReferencedCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueReferencedCell: StyledTextViewCell {

    static let inset = UIEdgeInsets(
        top: Styles.Sizes.inlineSpacing,
        left: Styles.Sizes.eventGutter,
        bottom: Styles.Sizes.inlineSpacing,
        right: Styles.Sizes.eventGutter + Styles.Sizes.icon.width + Styles.Sizes.rowSpacing
    )

    let statusButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        statusButton.setupAsLabel(icon: false)
        statusButton.isUserInteractionEnabled = false
        contentView.addSubview(statusButton)
        statusButton.snp.makeConstraints { make in
            make.right.equalTo(contentView).offset(-Styles.Sizes.eventGutter)
            make.size.equalTo(Styles.Sizes.icon)
            make.centerY.equalTo(contentView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(_ model: IssueReferencedModel) {
        set(renderer: model.string)

        let buttonState: UIButton.State
        switch model.state {
        case .closed: buttonState = .closed
        case .merged: buttonState = .merged
        case .open: buttonState = .open
        }
        statusButton.config(pullRequest: model.pullRequest, state: buttonState)
    }

}
