//
//  CenteredButtonCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class CenteredButtonCell: UICollectionViewCell {

    let label = UILabel()

    private var topSeparator: UIView? = nil
    private var bottomSeparator: UIView? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)

        topSeparator = contentView.addBorder(bottom: false, left: 0, right: 0)
        bottomSeparator = contentView.addBorder(bottom: true, left: 0, right: 0)

        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = Styles.Fonts.button
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(topSeparatorHidden: Bool = false, bottomSeparatorHidden: Bool = false) {
        topSeparator?.isHidden = topSeparatorHidden
        bottomSeparator?.isHidden = bottomSeparatorHidden
    }

}
