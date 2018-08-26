//
//  SpacerCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/26/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class SpacerCell: UICollectionViewCell {

    private let spaceView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        spaceView.backgroundColor = Styles.Colors.Gray.border.color
        contentView.addSubview(spaceView)
        spaceView.snp.makeConstraints { make in
            make.height.equalTo(1/UIScreen.main.scale)
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
