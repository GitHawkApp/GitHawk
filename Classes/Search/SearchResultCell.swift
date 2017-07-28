//
//  SearchResultCell.swift
//  Freetime
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class SearchResultCell: UICollectionViewCell {

    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true
        label.font = Styles.Fonts.button
        label.textColor = Styles.Colors.Gray.light.color
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(result: SearchResult) {
        label.text = result.name
    }
    
    override var accessibilityLabel: String? {
        get {
            return contentView.subviews
                .flatMap { $0.accessibilityLabel }
                .reduce("", { $0 + ".\n" + $1 })
        }
        set { }
    }
    
}
