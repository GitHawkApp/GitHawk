//
//  IssueCommentCodeBlockCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueCommentCodeBlockCell: UICollectionViewCell {

    static let inset = UIEdgeInsets(
        top: Styles.Sizes.rowSpacing,
        left: Styles.Sizes.gutter,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter
    )

    let textView = UITextView()
    let scrollView = UIScrollView()
    let overlay = CreateCollapsibleOverlay()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.clipsToBounds = true

        scrollView.backgroundColor = Styles.Colors.Gray.lighter
        contentView.addSubview(scrollView)

        textView.backgroundColor = .clear
        textView.scrollsToTop = false
        textView.isScrollEnabled = false
        scrollView.addSubview(textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // size the scrollview to the width of the cell but match its height to its content size
        // that way when the cell is collapsed, the scroll view isn't vertically scrollable
        scrollView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: scrollView.contentSize.height)
        LayoutCollapsible(layer: overlay, view: contentView)
    }

}

extension IssueCommentCodeBlockCell: IGListBindable {

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentCodeBlockModel else { return }
        viewModel.code.configure(textView: textView)
        textView.isEditable = false
        textView.isSelectable = true

        let contentSize = viewModel.code.textViewSize
        scrollView.contentSize = viewModel.code.textViewSize
        textView.frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)

        setNeedsLayout()
    }

}

extension IssueCommentCodeBlockCell: CollapsibleCell {

    func setCollapse(visible: Bool) {
        overlay.isHidden = !visible
    }
    
}
