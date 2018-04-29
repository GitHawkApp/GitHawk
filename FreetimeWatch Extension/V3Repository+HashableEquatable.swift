//
//  V3Repository+HashableEquatable.swift
//  FreetimeWatch Extension
//
//  Created by Ryan Nystrom on 4/28/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubAPI

extension V3Repository: Hashable, Equatable {

    public var hashValue: Int {
        return fullName.hashValue
    }

    public static func ==(lhs: V3Repository, rhs: V3Repository) -> Bool {
        // a little bit lazy, but fast & cheap for the watch app's purpose
        return lhs.id == rhs.id
        && lhs.fork == rhs.fork
        && lhs.isPrivate == rhs.isPrivate
    }

}
