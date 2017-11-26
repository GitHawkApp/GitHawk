//
//  NotificationNextPageCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class NotificationNextPageCell: UICollectionViewCell {

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

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
    }

    // MARK: Public API

    func configure(page: Int) {
        let format = NSLocalizedString("Load page %i", comment: "")
        label.text = String(format: format, page)
    }

    override var accessibilityLabel: String? {
        get {
            return AccessibilityHelper.generatedLabel(forCell: self)
        }
        set { }
    }

}
