//
//  SquawkViewDelegate.swift
//  Squawk
//
//  Created by Ryan Nystrom on 7/14/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

internal protocol SquawkViewDelegate: class {
    func didTapInfo(for view: SquawkView)
}
