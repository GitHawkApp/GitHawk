//
//  Layout.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

struct Styles {

    struct Sizes {
        static let gutter: CGFloat = 15
        static let icon = CGSize(width: 25, height: 25)
        static let avatarCornerRadius: CGFloat = 3
    }

    struct Fonts {
        static let body = UIFont.systemFont(ofSize: 17)
        static let secondary = UIFont.systemFont(ofSize: 17)
        static let title = UIFont.boldSystemFont(ofSize: 17)
    }

    struct Colors {
        static let blue = UIColor.fromHex("0366d6")
        static let green = UIColor.fromHex("28a745")
        static let red = UIColor.fromHex("cb2431")

        struct Gray {
            static let dark = UIColor.fromHex("24292e")
            static let medium = UIColor.fromHex("586069")
            static let light = UIColor.fromHex("a3aab1")
            static let ligher = UIColor.fromHex("fafbfc")
            static let border = UIColor.fromHex("dfe2e5")
        }
    }

}
