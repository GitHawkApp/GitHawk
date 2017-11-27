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
        left: Styles.Sizes.icon.width + 2*Styles.Sizes.columnSpacing,
        bottom: Styles.Fonts.secondary.lineHeight + 2*Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter
    )

    private let imageView = UIImageView()
    private let textView = AttributedStringView()
    private let detailLabel = UILabel()

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
            make.left.equalTo(Styles.Sizes.rowSpacing)
            make.size.equalTo(Styles.Sizes.icon)
        }

        contentView.addSubview(textView)
        contentView.addSubview(detailLabel)

        addBorder(.bottom, left: Styles.Sizes.gutter)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()

        let bounds = contentView.bounds
        textView.reposition(width: bounds.width)

        let textViewFrame = textView.frame

        // center the textView if there is no detail text
        if detailLabel.text?.isEmpty == true {
            textView.frame = CGRect(
                origin: CGPoint(x: textViewFrame.minX, y: (bounds.height - textViewFrame.height)/2),
                size: textViewFrame.size
            )
        } else {
            detailLabel.frame = CGRect(
                origin: CGPoint(x: textViewFrame.minX, y: textViewFrame.maxY + Styles.Sizes.rowSpacing),
                size: detailLabel.frame.size
            )
        }
    }

    func configure(viewModel: BookmarkViewModel, height: CGFloat) {
        imageView.image = viewModel.bookmark.type.icon.withRenderingMode(.alwaysTemplate)
        textView.configureAndSizeToFit(text: viewModel.text, width: contentView.bounds.width)

        // set "Owner/Repo #123" on the detail label if issue/PR, otherwise clear and collapse it
        switch viewModel.bookmark.type {
        case .issue, .pullRequest:
            let detailString = NSMutableAttributedString(
                string: "\(viewModel.bookmark.owner)/\(viewModel.bookmark.name)",
                attributes: [
                    .font: Styles.Fonts.secondaryBold,
                    .foregroundColor: Styles.Colors.Gray.light.color,
                    ]
            )
            detailString.append(NSAttributedString(
                string: " #\(viewModel.bookmark.number)",
                attributes: [
                    .font: Styles.Fonts.secondary,
                    .foregroundColor: Styles.Colors.Gray.light.color,
                ]
            ))
            detailLabel.attributedText = detailString
        default:
            detailLabel.text = ""
        }
        detailLabel.sizeToFit()
    }
}
