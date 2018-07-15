//
//  Squawk+Configuration.swift
//  Squawk
//
//  Created by Ryan Nystrom on 7/14/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

public extension Squawk {

    public struct Configuration {

        let text: String
        let textColor: UIColor
        let backgroundColor: UIColor
        let insets: UIEdgeInsets
        let maxWidth: CGFloat
        let hintMargin: CGFloat
        let hintSize: CGSize
        let cornerRadius: CGFloat
        let bottomPadding: CGFloat
        let borderColor: UIColor
        let dismissDuration: TimeInterval
        let buttonVisible: Bool
        let buttonLeftMargin: CGFloat
        let buttonTapHandler: (() -> Void)?

        public init(
            text: String,
            textColor: UIColor = .white,
            backgroundColor: UIColor = UIColor(white: 0.2, alpha: 0.7),
            insets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15),
            maxWidth: CGFloat = 300,
            hintMargin: CGFloat = 4,
            hintSize: CGSize = CGSize(width: 40, height: 4),
            cornerRadius: CGFloat = 6,
            bottomPadding: CGFloat = 15,
            borderColor: UIColor = UIColor(white: 0, alpha: 0.4),
            dismissDuration: TimeInterval = 4,
            buttonVisible: Bool = false,
            buttonLeftMargin: CGFloat = 8,
            buttonTapHandler: (() -> Void)? = nil
            ) {
            self.text = text
            self.textColor = textColor
            self.backgroundColor = backgroundColor
            self.insets = insets
            self.maxWidth = maxWidth
            self.hintMargin = hintMargin
            self.hintSize = hintSize
            self.cornerRadius = cornerRadius
            self.bottomPadding = bottomPadding
            self.borderColor = borderColor
            self.dismissDuration = dismissDuration
            self.buttonVisible = buttonVisible
            self.buttonLeftMargin = buttonLeftMargin
            self.buttonTapHandler = buttonTapHandler
        }
    }

}
