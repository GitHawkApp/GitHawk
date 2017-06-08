//
//  IssueCommentCodeBlockCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueCommentCodeBlockCell: UICollectionViewCell, IGListBindable, CollapsibleCell {

    static let inset = Styles.Sizes.textCellInset

    let label = UILabel()
    let scrollView = UIScrollView()
    let overlay = CreateCollapsibleOverlay()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white
        contentView.clipsToBounds = true

        scrollView.backgroundColor = Styles.Colors.Gray.lighter
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
        scrollView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: scrollView.contentSize.height)
        LayoutCollapsible(layer: overlay, view: contentView)
    }

    // MARK: IGListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentCodeBlockModel else { return }

        let contentSize = viewModel.code.textViewSize
        scrollView.contentSize = viewModel.code.textViewSize

        label.attributedText = viewModel.code.attributedText
        let textFrame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
        label.frame = UIEdgeInsetsInsetRect(textFrame, IssueCommentTextCell.inset)
    }

    // MARK: CollapsibleCell

    func setCollapse(visible: Bool) {
        overlay.isHidden = !visible
    }

}
