//
//  Defaults+ExternalLinks.swift
//  Freetime
//
//  Created by Ivan Smetanin on 08/12/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

extension UserDefaults {

    private static let defaultKey = "com.whoisryannystrom.freetime.is-need-open-external-links-in-safari"

    var shouldOpenExternalLinksInSafari: Bool {
        get {
            return bool(forKey: UserDefaults.defaultKey)
        }
        set {
            set(newValue, forKey: UserDefaults.defaultKey)
        }
    }

}
