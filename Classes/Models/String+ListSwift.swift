//
//  String+ListSwift.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/21/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

extension String: ListSwiftIdentifiable, ListSwiftEquatable {

    public var identifier: String {
        return self
    }

    public func isEqual(to object: ListSwiftDiffable) -> Bool {
        guard let object = object as? String else { return false }
        return self == object
    }

}
