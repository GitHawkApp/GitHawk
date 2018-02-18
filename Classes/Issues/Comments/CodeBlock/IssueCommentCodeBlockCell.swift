//
//  IssueCommentCodeBlockCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueCommentCodeBlockCell: IssueCommentBaseCell, ListBindable {

    static let scrollViewInset = UIEdgeInsets(
        top: Styles.Sizes.rowSpacing,
        left: 0,
        bottom: Styles.Sizes.rowSpacing,
        right: 0
    )
    static let textViewInset = UIEdgeInsets(
        top: Styles.Sizes.rowSpacing,
        left: Styles.Sizes.commentGutter,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.commentGutter
    )

    let textView = AttributedStringView()
    let scrollView = UIScrollView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        // make didSelectItem work for the cell
        // https://stackoverflow.com/a/24853578/940936
        scrollView.isUserInteractionEnabled = false
        contentView.addGestureRecognizer(scrollView.panGestureRecognizer)

        scrollView.backgroundColor = Styles.Colors.Gray.lighter.color
        contentView.addSubview(scrollView)

        scrollView.addSubview(textView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // size the scrollview to the width of the cell but match its height to its content size
        // that way when the cell is collapsed, the scroll view isn't vertically scrollable
        let inset = IssueCommentCodeBlockCell.scrollViewInset
        scrollView.frame = CGRect(
            x: inset.left,
            y: inset.top,
            width: contentView.bounds.width - inset.left - inset.right,
            height: scrollView.contentSize.height
        )
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentCodeBlockModel else { return }

        let contentSize = viewModel.contentSize
        scrollView.contentSize = contentSize

        textView.configureAndSizeToFit(text: viewModel.code, width: 0)
    }

}
