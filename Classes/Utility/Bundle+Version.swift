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
        let ver = versionNumber ?? Strings.unknown
        let build = buildNumber ?? "0"
        let format = NSLocalizedString("Version %@ (%@)", comment: "")
        return  String.localizedStringWithFormat(format, ver, build)
    }
    
}
