//
//  IssueDiffHunkPreviewCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/3/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledTextKit

final class IssueDiffHunkPreviewCell: IssueCommentBaseCell, ListBindable {

    static let textViewInset = UIEdgeInsets(
        top: Styles.Sizes.rowSpacing,
        left: 0,
        bottom: Styles.Sizes.rowSpacing,
        right: 0
    )

    let scrollView = UIScrollView()
    let textView = StyledTextView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(scrollView)
        scrollView.addSubview(textView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = CGRect(
            x: 0,
            y: 0,
            width: contentView.bounds.width,
            height: scrollView.contentSize.height
        )
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? StyledTextRenderer else { return }

        let width: CGFloat = 0
        scrollView.contentSize = viewModel.viewSize(in: width)
        textView.configure(with: viewModel, width: width)
    }

}
