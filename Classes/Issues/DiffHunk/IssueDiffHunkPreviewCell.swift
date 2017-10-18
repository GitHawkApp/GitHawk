//
//  IssueDiffHunkPreviewCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/3/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueDiffHunkPreviewCell: UICollectionViewCell, ListBindable {

    static let textViewInset = UIEdgeInsets(
        top: Styles.Sizes.rowSpacing,
        left: Styles.Sizes.gutter,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter
    )

    let scrollView = UIScrollView()
    let textView = AttributedStringView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        contentView.addSubview(scrollView)
        scrollView.addSubview(textView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
        scrollView.frame = CGRect(
            x: 0,
            y: 0,
            width: contentView.bounds.width,
            height: scrollView.contentSize.height
        )
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? NSAttributedStringSizing else { return }

        let width: CGFloat = 0
        scrollView.contentSize = viewModel.textViewSize(width)
        textView.configureAndSizeToFit(text: viewModel, width: width)
    }

}
