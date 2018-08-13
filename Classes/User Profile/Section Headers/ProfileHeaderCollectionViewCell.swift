
//
//  HeaderCollectionViewCell.swift
//  Freetime
//
//  Created by B_Litwin on 8/12/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

class ProfileHeaderCell: UICollectionViewCell {
    lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func layoutSubviews() {
        contentView.addSubview(label)
        
        label.font = Styles.Text.secondary.preferredFont
        label.textColor = Styles.Colors.Gray.light.color
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        backgroundColor = Styles.Colors.background
    }
    
    func configure(title: String) {
        label.text = NSLocalizedString(title, comment: "")
    }
}
