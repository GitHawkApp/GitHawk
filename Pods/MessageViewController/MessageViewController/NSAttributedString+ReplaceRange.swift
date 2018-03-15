//
//  NSAttributedString+ReplaceRange.swift
//  MessageViewController
//
//  Created by Nathan Tannar on 1/31/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

extension NSAttributedString {
    
    func replacingCharacters(in range: NSRange, with attributedString: NSAttributedString) -> NSMutableAttributedString {
        let ns = NSMutableAttributedString(attributedString: self)
        ns.replaceCharacters(in: range, with: attributedString)
        return ns
    }
    
    static func +(lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let ns = NSMutableAttributedString(attributedString: lhs)
        ns.append(rhs)
        return NSAttributedString(attributedString: ns)
    }
}

