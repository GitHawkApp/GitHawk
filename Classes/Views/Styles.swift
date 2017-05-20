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
        static let icon = CGSize(width: 20, height: 20)
        static let buttonIcon = CGSize(width: 25, height: 25)
        static let avatarCornerRadius: CGFloat = 3
        static let columnSpacing: CGFloat = 8
        static let rowSpacing: CGFloat = 8
        static let cellSpacing: CGFloat = 15
        static let tableCellHeight: CGFloat = 55
        static let tableSectionSpacing: CGFloat = 35
        static let avatar = CGSize(width: 30, height: 30)
    }

    struct Fonts {
        static let body = UIFont.systemFont(ofSize: 16)
        static let secondary = UIFont.systemFont(ofSize: 13)
        static let title = UIFont.boldSystemFont(ofSize: 14)
        static let button = UIFont.systemFont(ofSize: 17)
        static let headline = UIFont.boldSystemFont(ofSize: 22)
    }

    struct Colors {
        static let blue = UIColor.fromHex("0366d6")
        static let green = UIColor.fromHex("28a745")
        static let red = UIColor.fromHex("cb2431")
        static let background = UIColor.white

        struct Gray {
            static let dark = UIColor.fromHex("24292e")
            static let medium = UIColor.fromHex("586069")
            static let light = UIColor.fromHex("a3aab1")
            static let lighter = UIColor.fromHex("f6f8fa")
            static let border = UIColor.fromHex("dfe2e5")
        }
    }

}
