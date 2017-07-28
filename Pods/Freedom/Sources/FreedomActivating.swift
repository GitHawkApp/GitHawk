//
//  FreedomActivating.swift
//  Freedom
//
//  Created by Sabintsev, Arthur on 7/1/17.
//  Copyright © 2017 Arthur Ariel Sabintsev. All rights reserved.
//

import UIKit

protocol FreedomActivating {

    /// Deep Link associated with a third-party browser.
    var activityDeepLink: String? { get set }

    /// URL that should be launched in a third-party browser.
    var activityURL: URL? { get }
    
}
