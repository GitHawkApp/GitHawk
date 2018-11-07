//
//  IssueCommentTextCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import StyledTextKit

final class IssueCommentTextCell: IssueCommentBaseCell, ListBindable {

    static func inset(isLast: Bool) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 2,
            left: 0,
            bottom: isLast ? 0 : Styles.Sizes.rowSpacing,
            right: 0
        )
    }

    let textView = MarkdownStyledTextView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        isAccessibilityElement = true
        textView.gesturableAttributes = MarkdownAttribute.all
        contentView.addSubview(textView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textView.reposition(for: contentView.bounds.width)
    }

    // MARK: Accessibility

    override var accessibilityLabel: String? {
        get { return AccessibilityHelper.generatedLabel(forCell: self) }
        set { }
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? StyledTextRenderer else { return }
        configure(with: viewModel)
    }

    func configure(with model: StyledTextRenderer) {
        textView.configure(with: model, width: contentView.bounds.width)
    }

}
