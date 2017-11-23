//
//  Secrets.swift
//  Freetime
//
//  Created by Sherlock, James on 23/11/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

enum Secrets {
    
    enum GitHub {
        static let clientId = Secrets.environmentVariable(named: "GITHUB_CLIENT_ID")
        static let clientSecret = Secrets.environmentVariable(named: "GITHUB_CLIENT_SECRET")
    }
    
    enum Imgur {
        static let clientId = Secrets.environmentVariable(named: "IMGUR_CLIENT_ID")
    }
    
    fileprivate static func environmentVariable(named: String) -> String {
        
        let processInfo = ProcessInfo.processInfo
        
        guard let value = processInfo.environment[named] else {
            print("‼️ Missing Environment Variable: '\(named)'")
            print(UserDefaults.standard.value(forKey: named))
            return ""
        }
        
        return value
        
    }
    
}
