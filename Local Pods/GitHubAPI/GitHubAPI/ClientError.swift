//
//  ClientError.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public enum ClientError: Error {
    case unauthorized
    case mismatchedInput
    case outputNil(Error?)
    case network(Error?)
}
