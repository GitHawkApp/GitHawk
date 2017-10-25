//
//  LoadMoreCell.swift
//  Freetime
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class LoadMoreCell: UICollectionViewCell {

    private let label = UILabel()

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
        label.text = NSLocalizedString("Load More", comment: "")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
    }

    override var accessibilityLabel: String? {
        get { return NSLocalizedString("Load More", comment: "") }
        set { }
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                label.alpha = 0.5
            } else {
                label.alpha = 1
            }
        }
    }
    
}
