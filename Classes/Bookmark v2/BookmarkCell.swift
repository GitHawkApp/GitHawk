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
        left: Styles.Sizes.gutter + Styles.Sizes.icon.width + Styles.Sizes.columnSpacing,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter
    )

    private let imageView = UIImageView()
    private let textLabel = UILabel()

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

        textLabel.numberOfLines = 0

        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(imageView.snp.right).offset(Styles.Sizes.columnSpacing)
            make.right.equalTo(Styles.Sizes.gutter)
        }

        addBorder(.bottom, left: Styles.Sizes.gutter)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
    }

    func configure(viewModel: BookmarkViewModel, height: CGFloat) {
        imageView.image = viewModel.bookmark.type.icon.withRenderingMode(.alwaysTemplate)
        textLabel.attributedText = viewModel.text.attributedText
    }

}
