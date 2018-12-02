//
//  ContextMenu+Position.swift
//  ContextMenu
//
//  Created by Ryan Nystrom on 12/2/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

extension ContextMenu {

    /// Position of the menu container relative to the source view.
    public enum Position {

        /// Snap to the most visible corner.
        case `default`

        /// Snap to the center X.
        case centerX

    }
    
}
