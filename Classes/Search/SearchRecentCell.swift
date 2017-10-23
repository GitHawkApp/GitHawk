//
//  SearchRecentCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class SearchRecentCell: SwipeSelectableCell {

    private let label = UILabel()
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = Styles.Colors.Gray.light.color
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.gutter)
            make.width.equalTo(Styles.Sizes.icon.width)
        }

        label.textColor = Styles.Colors.Gray.dark.color
        label.font = Styles.Fonts.body
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(imageView.snp.right).offset(Styles.Sizes.gutter)
            make.right.lessThanOrEqualTo(-Styles.Sizes.gutter)
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

    // MARK: Public API

    func configure(viewModel: SearchRecentViewModel) {
        imageView.image = viewModel.icon.withRenderingMode(.alwaysTemplate)
        label.attributedText = viewModel.displayText
    }

}
