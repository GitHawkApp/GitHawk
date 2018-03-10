//
//  ContextMenuOptions.swift
//  ThingsUI
//
//  Created by Ryan Nystrom on 3/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension ContextMenu {

    public struct Options {

        let durations: AnimationDurations
        let containerStyle: ContainerStyle
        let menuStyle: MenuStyle
        let haptics: Bool

        public init(
            durations: AnimationDurations = AnimationDurations(),
            containerStyle: ContainerStyle = ContainerStyle(),
            menuStyle: MenuStyle = .default,
            haptics: Bool = true
            ) {
            self.durations = durations
            self.containerStyle = containerStyle
            self.menuStyle = menuStyle
            self.haptics = haptics
        }
    }

}
