//
//  NSRegularExpression+StaticString.swift
//  Freetime
//
//  Created by Ehud Adler on 12/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation


extension NSRegularExpression {

    convenience init(_ pattern: StaticString, options: NSRegularExpression.Options = []) {
        do {
            try self.init(pattern: "\(pattern)", options: options)
        } catch {
            preconditionFailure("Illegal Regex pattern: \(pattern)")
        }
    }
}
