//
//  Signature.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

enum Signature {

    private static let key = "com.freetime.Signature.enabled"

    static var enabled: Bool {
        get {
            // using the object API allows us to return true for init state
            return UserDefaults.standard.object(forKey: key) as? Bool ?? true
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }

    static func signed(text: String) -> String {
        guard enabled else { return text }
        let format = NSLocalizedString("Sent with %@", comment: "")
        let signature = String.localizedStringWithFormat(format, "<a href=\"http://githawk.com\">GitHawk</a>")
        return text + "\n\n<sub>\(signature)</sub>"
    }

}
