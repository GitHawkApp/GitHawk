//
//  ContextMenu+Animations.swift
//  ThingsUI
//
//  Created by Ryan Nystrom on 3/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension ContextMenu {

    /// Animation durations and properties.
    public struct AnimationDurations {

        /// The duration of the presentation animation.
        public let present: TimeInterval

        /// The duration of the spring animation during presentation. Setting a longer duration than `present` results
        /// in a more natural transition.
        public let springPresent: TimeInterval

        /// The spring damping to use in the presentation. See `UIView.animate(withDuration:, delay:,
        /// usingSpringWithDamping:, initialSpringVelocity:, options:, animations: , completion:)`
        public let springDamping: CGFloat

        /// The spring velocity to use in the presentation. See `UIView.animate(withDuration:, delay:,
        /// usingSpringWithDamping:, initialSpringVelocity:, options:, animations: , completion:)`
        public let springVelocity: CGFloat

        /// The duration of the dismiss animation.
        public let dismiss: TimeInterval

        /// The animation duration when the `preferredContentSize` changes.
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
