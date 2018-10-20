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
}

extension ClientError: LocalizedError {

    public var localizedDescription: String {
        switch self {
        case .unauthorized:
            return NSLocalizedString("You are unauthorized to make this request.", comment: "")
        case .mismatchedInput:
            return NSLocalizedString("There was an error parsing this response.", comment: "")
        }
    }

}
