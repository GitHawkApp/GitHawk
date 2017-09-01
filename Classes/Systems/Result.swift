//
//  Result.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/27/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

enum Result<T> {
    case error(Error?)
    case success(T)
}
