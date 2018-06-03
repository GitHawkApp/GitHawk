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

    static let inset = UIEdgeInsets(
        top: 2,
        left: Styles.Sizes.commentGutter,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.commentGutter
    )

    let textView = MarkdownStyledTextView()

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
        textView.configure(with: viewModel, width: contentView.bounds.width)
    }

}
