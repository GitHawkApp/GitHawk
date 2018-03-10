//
//  ContextMenu+ContainerStyle.swift
//  ThingsUI
//
//  Created by Ryan Nystrom on 3/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension ContextMenu {

    public struct ContainerStyle {

        public let cornerRadius: CGFloat
        public let shadowRadius: CGFloat
        public let shadowOpacity: Float
        public let xPadding: CGFloat
        public let yPadding: CGFloat
        public let edgePadding: CGFloat
        public let backgroundColor: UIColor
        public let overlayColor: UIColor
        public let motionEffect: Bool

        public init(
            cornerRadius: CGFloat = 8,
            shadowRadius: CGFloat = 15,
            shadowOpacity: Float = 0.1,
            xPadding: CGFloat = 8,
            yPadding: CGFloat = 8,
            edgePadding: CGFloat = 15,
            backgroundColor: UIColor = .white,
            overlayColor: UIColor = UIColor(white: 0, alpha: 0.3),
            motionEffect: Bool = true
            ) {
            self.cornerRadius = cornerRadius
            self.shadowRadius = shadowRadius
            self.shadowOpacity = shadowOpacity
            self.xPadding = xPadding
            self.yPadding = yPadding
            self.edgePadding = edgePadding
            self.backgroundColor = backgroundColor
            self.overlayColor = overlayColor
            self.motionEffect = motionEffect
        }

    }

}
