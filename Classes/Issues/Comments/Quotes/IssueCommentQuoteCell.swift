//
//  IssueCommentQuoteCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueCommentQuoteCell: UICollectionViewCell, IGListBindable, CollapsibleCell {

    static let borderWidth: CGFloat = 2
    static let inset = UIEdgeInsets(
        top: 0,
        left: Styles.Sizes.gutter + IssueCommentQuoteCell.borderWidth + Styles.Sizes.columnSpacing,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter
    )

    private let label = UILabel()
    private let border = UIView()
    private let overlay = CreateCollapsibleOverlay()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white
        contentView.clipsToBounds = true

        border.backgroundColor = Styles.Colors.Gray.light
        contentView.addSubview(border)

        label.numberOfLines = 0
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        LayoutCollapsible(layer: overlay, view: contentView)
        let labelFrame = label.frame
        border.frame = CGRect(
            x: Styles.Sizes.gutter,
            y: labelFrame.minY,
            width: IssueCommentQuoteCell.borderWidth,
            height: labelFrame.height
        )
    }

    //MARK: IGListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentQuoteModel else { return }
        label.attributedText = viewModel.quote.attributedText
        let contentSize = viewModel.quote.textViewSize
        let textFrame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
        label.frame = UIEdgeInsetsInsetRect(textFrame, IssueCommentQuoteCell.inset)
    }

    // MARK: CollapsibleCell

    func setCollapse(visible: Bool) {
        overlay.isHidden = !visible
    }

}
