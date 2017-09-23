//
//  TabmanBar+Item.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public extension TabmanBar {
    
    /// An item to display in a TabmanBar.
    public struct Item: Any {
        
        // MARK: Properties
        
        /// The title to display for the item.
        public private(set) var title: String?
        /// The image to display for the item.
        public private(set) var image: UIImage?
        
        // MARK: Init
        
        /// Create an item with a title.
        ///
        /// - Parameter title: The title to display.
        public init(title: String) {
            self.title = title
        }
        
        /// Create an item with an image.
        ///
        /// - Parameter image: Image to display.
        public init(image: UIImage) {
            self.image = image
        }
      
        /// Create an item with a title and an image
        ///
        /// - Parameter title: The title to display.
        /// - Parameter image: Image to display.
        public init(title: String, image: UIImage) {
            self.title = title
            self.image = image
        }
    }
}
