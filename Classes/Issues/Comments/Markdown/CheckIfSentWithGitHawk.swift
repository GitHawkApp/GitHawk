//
//  CheckIfSentWithGitHawk.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/29/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

func CheckIfSentWithGitHawk(markdown: String) -> (sentWithGitHawk: Bool, markdown: String) {
    let nsstring = markdown as NSString
    let range = nsstring.range(of: Signature.signature, options: .backwards)
    if range.location != NSNotFound && range.location + range.length == nsstring.length {
        return (true, nsstring.replacingCharacters(in: range, with: ""))
    }
    return (false, markdown)
}
