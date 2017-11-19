//
//  IssueCommentQuoteCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueCommentQuoteCell: DoubleTappableCell, ListBindable, CollapsibleCell {

    static let borderWidth: CGFloat = 2
    static func inset(quoteLevel: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 0,
            left: Styles.Sizes.gutter + (IssueCommentQuoteCell.borderWidth + Styles.Sizes.columnSpacing) * CGFloat(quoteLevel),
            bottom: Styles.Sizes.rowSpacing,
            right: Styles.Sizes.gutter
        )
    }

    let textView = AttributedStringView()
    private var borders = [UIView]()
    private let overlay = CreateCollapsibleOverlay()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        contentView.clipsToBounds = true

        contentView.addSubview(textView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
        LayoutCollapsible(layer: overlay, view: contentView)
        textView.reposition(width: contentView.bounds.width)
        for (i, border) in borders.enumerated() {
            border.frame = CGRect(
                x: Styles.Sizes.gutter + (IssueCommentQuoteCell.borderWidth + Styles.Sizes.columnSpacing) * CGFloat(i),
                y: 0,
                width: IssueCommentQuoteCell.borderWidth,
                height: contentView.bounds.height - Styles.Sizes.rowSpacing
            )
        }
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentQuoteModel else { return }

        // hack, remove all border views and add them again
        for border in borders {
            border.removeFromSuperview()
        }
        borders.removeAll()
        for _ in 0..<viewModel.level {
            let border = UIView()
            border.backgroundColor = Styles.Colors.Gray.light.color
            contentView.addSubview(border)
            borders.append(border)
        }

        textView.configureAndSizeToFit(text: viewModel.quote, width: contentView.bounds.width)

        setNeedsLayout()
    }

    // MARK: CollapsibleCell

    func setCollapse(visible: Bool) {
        overlay.isHidden = !visible
    }

}
