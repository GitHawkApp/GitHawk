//
//  ExpandedHitTestButton.swift
//  MessageViewController
//
//  Created by Ryan Nystrom on 4/21/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

internal final class ExpandedHitTestButton: UIButton {

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard isHidden == false, window != nil else { return false }
        return bounds.insetBy(dx: -10, dy: -10).contains(point)
    }

}
