//
//  IssueCommentTextCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueCommentTextCell: IssueCommentBaseCell, ListBindable, CollapsibleCell {

    static let inset = UIEdgeInsets(
        top: 0,
        left: Styles.Sizes.commentGutter,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.commentGutter
    )

    let textView = AttributedStringView()
    let overlay = CreateCollapsibleOverlay()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isAccessibilityElement = true

        contentView.addSubview(textView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        LayoutCollapsible(layer: overlay, view: contentView)
        textView.reposition(width: contentView.bounds.width)
    }

    // MARK: Accessibility

    override var accessibilityLabel: String? {
        get {
            return AccessibilityHelper.generatedLabel(forCell: self)
        }
        set { }
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? NSAttributedStringSizing else { return }
        textView.configureAndSizeToFit(text: viewModel, width: contentView.bounds.width)
    }

    // MARK: CollapsibleCell

    func setCollapse(visible: Bool) {
        overlay.isHidden = !visible
    }

}
