//
//  BookmarkCell.swift
//  Freetime
//
//  Created by Hesham Salman on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class BookmarkCell: SwipeSelectableCell {

    static let titleInset = UIEdgeInsets(
        top: Styles.Sizes.rowSpacing,
        left: Styles.Sizes.gutter * 2 + Styles.Sizes.icon.width,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.eventGutter
    )

    private static let compactInset = UIEdgeInsets(
        top: 17.5,
        left: Styles.Sizes.gutter * 2 + Styles.Sizes.icon.width,
        bottom: 17.5,
        right: Styles.Sizes.eventGutter
    )

    private let imageView = UIImageView()
    private let textView = AttributedStringView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        contentView.clipsToBounds = true

        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = Styles.Colors.Blue.medium.color
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.gutter)
            make.width.equalTo(Styles.Sizes.icon.width)
        }

        addSubview(textView)

        addBorder(.bottom, left: RepositorySummaryCell.titleInset.left)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
        textView.reposition(width: contentView.bounds.width)
    }

    func configure(viewModel: BookmarkViewModel, height: CGFloat) {
        if height == Styles.Sizes.tableCellHeightLarge {
            viewModel.text = NSAttributedStringSizing(containerWidth: contentView.bounds.width, attributedText: viewModel.text.attributedText, inset: BookmarkCell.compactInset)
        }
        textView.configureAndSizeToFit(text: viewModel.text, width: contentView.bounds.width)
        imageView.image = viewModel.bookmark.type.icon.withRenderingMode(.alwaysTemplate)
    }

}
