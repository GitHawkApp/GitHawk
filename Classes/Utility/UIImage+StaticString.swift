//
//  UIImage+StaticString.swift
//  Freetime
//
//  Created by Ehud Adler on 12/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

extension UIImage {

    convenience init(named: StaticString) {
        self.init(named: "\(named)")!
    }
}
