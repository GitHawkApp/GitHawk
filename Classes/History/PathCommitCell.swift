//
//  PathCommitCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/20/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class PathCommitCell: SelectableCell {

    static let inset = UIEdgeInsets(
        top: Styles.Sizes.rowSpacing,
        left: Styles.Sizes.gutter,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter + Styles.Sizes.columnSpacing + Styles.Sizes.icon.width
    )

    private let textView = MarkdownStyledTextView()
    private let disclosureImageView = UIImageView(image: UIImage(named: "chevron-right")?.withRenderingMode(.alwaysTemplate))

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        contentView.addSubview(textView)

        disclosureImageView.tintColor = Styles.Colors.Gray.light.color
        contentView.addSubview(disclosureImageView)

        disclosureImageView.snp.makeConstraints { make in
            make.right.equalTo(-Styles.Sizes.gutter)
            make.centerY.equalToSuperview()
        }

        addBorder(.bottom, left: Styles.Sizes.gutter)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textView.reposition(for: contentView.bounds.width)
    }

    // MARK: Public API

    func configure(with model: PathCommitModel) {
        textView.configure(with: model.text, width: contentView.bounds.width)
    }

}
