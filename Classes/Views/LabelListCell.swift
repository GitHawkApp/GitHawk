//
//  LabelListCell.swift
//  Freetime
//
//  Created by Joe Rocca on 12/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

class LabelListCell: UICollectionViewCell {
    
    static let reuse = "cell"
    
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 3.0
        
        nameLabel.font = Styles.Fonts.smallTitle
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(Styles.Sizes.labelTextPadding)
            make.right.equalTo(contentView).offset(-Styles.Sizes.labelTextPadding)
            make.centerY.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public API
    
    func configure(label: RepositoryLabel) {
        let color = UIColor.fromHex(label.color)
        backgroundColor = color
        nameLabel.text = label.name
        nameLabel.textColor = color.textOverlayColor
    }
}
