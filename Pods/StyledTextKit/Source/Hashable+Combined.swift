//
//  Hashable+Combined.swift
//  StyledTextKit
//
//  Created by Ryan Nystrom on 12/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension Hashable {

    public func combineHash<T: Hashable>(with hashableOther: T) -> Int {
        let ownHash = self.hashValue
        let otherHash = hashableOther.hashValue
        return (ownHash << 5) &+ ownHash &+ otherHash
    }

}
