//
//  GitHubUserSession+NetworkingConfigs.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/28/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public extension GitHubUserSession {

    var networkingConfigs: (token: String, useOauth: Bool) {
        let useOauth: Bool
        switch authMethod {
        case .oauth: useOauth = true
        case .pat: useOauth = false
        }
        return (token, useOauth)
    }
    
}
