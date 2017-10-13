//
//  ResponderButton.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 6/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class ResponderButton: UIButton {

    override var canBecomeFirstResponder: Bool {
        return true
    }

}
