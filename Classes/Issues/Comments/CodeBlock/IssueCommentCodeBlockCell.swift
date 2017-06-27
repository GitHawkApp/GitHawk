//
//  IssueCommentCodeBlockCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueCommentCodeBlockCell: UICollectionViewCell, ListBindable, CollapsibleCell {

    static let scrollViewInset = UIEdgeInsets(
        top: Styles.Sizes.rowSpacing,
        left: 0,
        bottom: Styles.Sizes.rowSpacing,
        right: 0
    )
    static let textViewInset = UIEdgeInsets(
        top: Styles.Sizes.rowSpacing,
        left: Styles.Sizes.gutter,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter
    )

    let label = UILabel()
    let scrollView = UIScrollView()
    let overlay = CreateCollapsibleOverlay()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white
        contentView.clipsToBounds = true

        // make didSelectItem work for the cell
        // https://stackoverflow.com/a/24853578/940936
        scrollView.isUserInteractionEnabled = false
        contentView.addGestureRecognizer(scrollView.panGestureRecognizer)

        scrollView.backgroundColor = Styles.Colors.Gray.lighter.color
        contentView.addSubview(scrollView)

        label.numberOfLines = 0
        scrollView.addSubview(label)
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
        LayoutCollapsible(layer: overlay, view: contentView)
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentCodeBlockModel else { return }

        let contentSize = viewModel.contentSize
        scrollView.contentSize = contentSize

        label.attributedText = viewModel.code.attributedText
        let textFrame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
        label.frame = UIEdgeInsetsInsetRect(textFrame, IssueCommentCodeBlockCell.textViewInset)
    }

    // MARK: CollapsibleCell

    func setCollapse(visible: Bool) {
        overlay.isHidden = !visible
    }

}
