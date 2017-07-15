//
//  Bundle+Version.swift
//  Freetime
//
//  Created by Sherlock, James on 15/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension Bundle {
    
    var versionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    var prettyVersionString: String {
        return NSLocalizedString("Version", comment: "") + " \(versionNumber ?? "Unknown") (\(buildNumber ?? "0"))"
    }
    
}
