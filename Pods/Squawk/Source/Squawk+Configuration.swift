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
        let backgroundColor: UIColor
        let insets: UIEdgeInsets
        let maxWidth: CGFloat
        let hintTopMargin: CGFloat
        let hintSize: CGSize
        let cornerRadius: CGFloat
        let borderColor: UIColor
        let dismissDuration: TimeInterval
        let buttonVisible: Bool
        let buttonLeftMargin: CGFloat
        let buttonTapHandler: (() -> Void)?

        init(
            text: String,
            backgroundColor: UIColor = UIColor(white: 0.2, alpha: 1),
            insets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15),
            maxWidth: CGFloat = 300,
            hintTopMargin: CGFloat = 8,
            hintSize: CGSize = CGSize(width: 40, height: 4),
            cornerRadius: CGFloat = 6,
            borderColor: UIColor = UIColor(white: 0, alpha: 0.4),
            dismissDuration: TimeInterval = 4,
            buttonVisible: Bool = false,
            buttonLeftMargin: CGFloat = 0,
            buttonTapHandler: (() -> Void)? = nil
            ) {
            self.text = text
            self.backgroundColor = backgroundColor
            self.insets = insets
            self.maxWidth = maxWidth
            self.hintTopMargin = hintTopMargin
            self.hintSize = hintSize
            self.cornerRadius = cornerRadius
            self.borderColor = borderColor
            self.dismissDuration = dismissDuration
            self.buttonVisible = buttonVisible
            self.buttonLeftMargin = buttonLeftMargin
            self.buttonTapHandler = buttonTapHandler
        }
    }

}
