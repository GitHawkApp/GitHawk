//
//  String+Substring.swift
//  Freetime
//
//  Created by Joan Disho on 07.05.18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

extension String {
    func substringUntilNewLine() -> String {
        let substring = self.components(separatedBy: .newlines)[0]
        return self == substring ? self : substring + " ..."
    }
}
