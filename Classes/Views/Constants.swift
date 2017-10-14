//
//  Constants.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

enum Constants {

    enum URLs {
        static let repository = "https://github.com/rnystrom/GitHawk/"
        static let website = "http://www.githawk.com/"
        static let blog = "http://blog.githawk.com/"
    }

    enum Strings {
        static let all = NSLocalizedString("All", comment: "")
        static let unread = NSLocalizedString("Unread", comment: "")
        static let ok = NSLocalizedString("OK", comment: "")
        static let cancel = NSLocalizedString("Cancel", comment: "")
        static let yes = NSLocalizedString("Yes", comment: "")
        static let no = NSLocalizedString("No", comment: "")
        static let signin = NSLocalizedString("Sign In", comment: "")
        static let signout = NSLocalizedString("Sign out", comment: "")
        static let open = NSLocalizedString("Open", comment: "")
        static let close = NSLocalizedString("Close", comment: "")
        static let closed = NSLocalizedString("Closed", comment: "")
        static let reopen = NSLocalizedString("Reopen", comment: "")
        static let reopened = NSLocalizedString("Reopened", comment: "")
        static let unknown = NSLocalizedString("Unknown", comment: "")
        static let merged = NSLocalizedString("Merged", comment: "")
        static let locked = NSLocalizedString("Locked", comment: "")
        static let newIssue = NSLocalizedString("New Issue", comment: "")
        static let bullet = "\u{2022}"
        static let bulletHollow = "\u{25E6}"
        static let search = NSLocalizedString("Search", comment: "")
    }
}
