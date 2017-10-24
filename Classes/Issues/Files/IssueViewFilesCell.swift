//
//  IssueViewFilesCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/11/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueViewFilesCell: SelectableCell {

    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.text = NSLocalizedString("View Files", comment: "")
        label.font = Styles.Fonts.secondary
        label.textColor = Styles.Colors.Blue.medium.color
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.centerY.equalTo(contentView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
