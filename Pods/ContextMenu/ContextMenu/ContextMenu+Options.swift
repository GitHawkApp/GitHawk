//
//  ContextMenuOptions.swift
//  ThingsUI
//
//  Created by Ryan Nystrom on 3/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension ContextMenu {

    /// Display and behavior options for a menu.
    public struct Options {

        /// Animation durations and properties.
        let durations: AnimationDurations

        /// Appearance properties for the menu container.
        let containerStyle: ContainerStyle

        /// Style options for menu behavior.
        let menuStyle: MenuStyle

        /// Trigger haptic feedback when the menu is shown.
        let hapticsStyle: UIImpactFeedbackGenerator.FeedbackStyle?

        public init(
            durations: AnimationDurations = AnimationDurations(),
            containerStyle: ContainerStyle = ContainerStyle(),
            menuStyle: MenuStyle = .default,
            hapticsStyle: UIImpactFeedbackGenerator.FeedbackStyle? = nil
            ) {
            self.durations = durations
            self.containerStyle = containerStyle
            self.menuStyle = menuStyle
            self.hapticsStyle = hapticsStyle
        }
    }

}
