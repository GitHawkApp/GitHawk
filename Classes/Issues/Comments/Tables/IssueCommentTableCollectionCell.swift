//
//  IssueCommentTableCollectionCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import StyledText

final class IssueCommentTableCollectionCell: UICollectionViewCell {

    static let inset = UIEdgeInsets(
        top: Styles.Sizes.rowSpacing,
        left: Styles.Sizes.columnSpacing,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.columnSpacing
    )

    let textView = MarkdownStyledTextView()

    var bottomBorder: UIView?
    var rightBorder: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(textView)
        contentView.addBorder(.left)
        contentView.addBorder(.top)

        bottomBorder = contentView.addBorder(.bottom)
        rightBorder = contentView.addBorder(.right)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(_ model: StyledTextRenderer) {
        textView.configure(with: model, width: 0)
    }

    func setRightBorder(visible: Bool) {
        rightBorder?.isHidden = !visible
    }

    func setBottomBorder(visible: Bool) {
        bottomBorder?.isHidden = !visible
    }

}
