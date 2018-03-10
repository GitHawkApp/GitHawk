//
//  ContextMenu+Animations.swift
//  ThingsUI
//
//  Created by Ryan Nystrom on 3/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension ContextMenu {

    public struct AnimationDurations {

        public let present: TimeInterval
        public let springPresent: TimeInterval
        public let springDamping: CGFloat
        public let springVelocity: CGFloat
        public let dismiss: TimeInterval
        public let resize: TimeInterval

        public init(
            present: TimeInterval = 0.3,
            springPresent: TimeInterval = 0.5,
            springDamping: CGFloat = 0.8,
            springVelocity: CGFloat = 0.5,
            dismiss: TimeInterval = 0.15,
            resize: TimeInterval = 0.3
            ) {
            self.present = present
            self.springPresent = springPresent
            self.springDamping = springDamping
            self.springVelocity = springVelocity
            self.dismiss = dismiss
            self.resize = resize
        }
    }

}
