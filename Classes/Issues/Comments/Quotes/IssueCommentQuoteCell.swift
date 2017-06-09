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

    private let textView = UIView()
    private let border = UIView()
    private let overlay = CreateCollapsibleOverlay()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white
        contentView.clipsToBounds = true

        border.backgroundColor = Styles.Colors.Gray.light
        contentView.addSubview(border)

        contentView.addSubview(textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        LayoutCollapsible(layer: overlay, view: contentView)
        border.frame = CGRect(
            x: Styles.Sizes.gutter,
            y: 0,
            width: IssueCommentQuoteCell.borderWidth,
            height: contentView.bounds.height - Styles.Sizes.rowSpacing
        )
    }

    //MARK: IGListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentQuoteModel else { return }
        textView.configureAndLayout(viewModel.quote)
    }

    // MARK: CollapsibleCell

    func setCollapse(visible: Bool) {
        overlay.isHidden = !visible
    }

}
