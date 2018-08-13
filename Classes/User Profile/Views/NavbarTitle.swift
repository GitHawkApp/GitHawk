//
//  NavbarTitle.swift
//  Freetime
//
//  Created by B_Litwin on 8/13/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

//heavy inspiration from

class NavbarTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .clear
        numberOfLines = 2
        textAlignment = .center
        lineBreakMode = .byTruncatingMiddle
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
        
    func configure(
        title: String,
        subtitle: String?,
        accessibilityLabel: String? = nil,
        accessibilityHint: String? = nil
    ) {
        let titleAttributes: [NSAttributedStringKey: Any] = [
            .font: Styles.Text.bodyBold.preferredFont,
            .foregroundColor: Styles.Colors.Gray.dark.color
        ]
        
        let attributedTitle = NSMutableAttributedString(string: title, attributes: titleAttributes)
        if let subtitle = subtitle {
            attributedTitle.append(NSAttributedString(string: "\n"))
            attributedTitle.append(NSAttributedString(string: subtitle, attributes: [
                .font: Styles.Text.secondaryBold.preferredFont,
                .foregroundColor: Styles.Colors.Gray.light.color
                ]))
        }
        
        attributedText = attributedTitle
        self.accessibilityLabel = accessibilityLabel ?? title
        self.accessibilityHint = accessibilityHint
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

