//
//  BookmarkMigrationCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/23/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol BookmarkMigrationCellDelegate: class {
    func didTapMigrate(for cell: BookmarkMigrationCell)
}

final class BookmarkMigrationCell: UICollectionViewCell {

    weak var delegate: BookmarkMigrationCellDelegate?

    private let label = UILabel()
    private let button = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(label)
        contentView.addSubview(button)

        label.text = NSLocalizedString(
            "Bookmarks are now stored and synced in iCloud. Tap below migrate.",
            comment: ""
        )
        label.font = Styles.Text.secondary.preferredFont
        label.textColor = Styles.Colors.Gray.medium.color
        label.numberOfLines = 0

        button.setTitle(NSLocalizedString("Migrate", comment: ""), for: .normal)
        button.setTitleColor(Styles.Colors.Blue.medium.color, for: .normal)
        button.titleLabel?.font = Styles.Text.secondaryBold.preferredFont

        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(-Styles.Sizes.tableCellHeightLarge)
            make.width.lessThanOrEqualToSuperview().offset(-Styles.Sizes.gutter * 2)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(Styles.Sizes.rowSpacing * 2)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
