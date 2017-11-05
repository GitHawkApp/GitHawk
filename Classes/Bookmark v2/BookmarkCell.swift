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

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let secondaryLabel = UILabel()
    private let detailStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = Styles.Colors.Blue.medium.color
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.gutter)
            make.width.equalTo(Styles.Sizes.icon.width)
        }

        titleLabel.numberOfLines = 0
        secondaryLabel.numberOfLines = 0

        detailStackView.axis = .vertical
        detailStackView.alignment = .leading
        detailStackView.distribution = .fill
        detailStackView.spacing = Styles.Sizes.rowSpacing
        detailStackView.addArrangedSubview(titleLabel)
        detailStackView.addArrangedSubview(secondaryLabel)
        contentView.addSubview(detailStackView)
        detailStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(Styles.Sizes.rowSpacing)
            make.bottom.equalTo(contentView).offset(-Styles.Sizes.rowSpacing)
            make.left.equalTo(imageView.snp.right).offset(Styles.Sizes.columnSpacing)
            make.width.equalTo(contentView).offset(-Styles.Sizes.icon.width - Styles.Sizes.columnSpacing * 2 - Styles.Sizes.gutter)
        }

        addBorder(.bottom, left: RepositorySummaryCell.titleInset.left)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(viewModel: BookmarkViewModel) {
        titleLabel.attributedText = viewModel.repositoryName
        secondaryLabel.text = viewModel.bookmarkTitle
        imageView.image = viewModel.icon
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}
