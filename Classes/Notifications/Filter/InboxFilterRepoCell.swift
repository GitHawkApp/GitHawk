//
//  InboxFilterRepoCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/2/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class InboxFilterRepoCell: SelectableCell {

    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        overlayColor = Styles.Colors.Gray.medium.color
        accessibilityIdentifier = "inbox-filter-repo-cell"

        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        contentView.addSubview(label)

        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(Styles.Sizes.gutter)
            make.right.lessThanOrEqualTo(-Styles.Sizes.gutter)
        }

        let border = contentView.addBorder(.bottom, left: Styles.Sizes.gutter, right: -Styles.Sizes.gutter)
        border.backgroundColor = Styles.Colors.Gray.medium.color
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(owner: String, name: String) {
        let text = NSMutableAttributedString(string: "\(owner)/", attributes: [
            .foregroundColor: Styles.Colors.Gray.light.color,
            .font: Styles.Text.body.preferredFont
            ])
        text.append(NSAttributedString(string: "\(name)", attributes: [
            .foregroundColor: UIColor.white,
            .font: Styles.Text.bodyBold.preferredFont
            ]))
        label.attributedText = text
    }

}
