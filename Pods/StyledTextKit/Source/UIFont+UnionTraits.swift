//
//  UIFont+UnionTraits.swift
//  StyledTextKit
//
//  Created by Ryan Nystrom on 12/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

internal extension UIFont {

    func addingTraits(traits: UIFontDescriptorSymbolicTraits) -> UIFont {
        let newTraits = fontDescriptor.symbolicTraits.union(traits)
        guard let descriptor = fontDescriptor.withSymbolicTraits(newTraits)
            else { return self }
        return UIFont(descriptor: descriptor, size: 0)
    }

}
