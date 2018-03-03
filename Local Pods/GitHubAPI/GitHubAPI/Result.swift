//
//  Result.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error?)
}
