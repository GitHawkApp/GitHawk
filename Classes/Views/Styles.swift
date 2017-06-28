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
        static let tableCellHeight: CGFloat = 44
        static let tableSectionSpacing: CGFloat = 35
        static let avatar = CGSize(width: 30, height: 30)
        static let inlineSpacing: CGFloat = 4
        static let listInsetLarge = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        static let listInsetTight = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        static let textCellInset = UIEdgeInsets(
            top: 0,
            left: Styles.Sizes.gutter,
            bottom: Styles.Sizes.rowSpacing,
            right: Styles.Sizes.gutter
        )

        struct Text {
            static let body: CGFloat = 16
            static let secondary: CGFloat = 13
            static let title: CGFloat = 14
            static let button: CGFloat = 16
            static let headline: CGFloat = 18
            static let smallTitle: CGFloat = 12
            static let h1: CGFloat = 24
            static let h2: CGFloat = 22
            static let h3: CGFloat = 20
            static let h4: CGFloat = 18
            static let h5: CGFloat = 16
            static let h6: CGFloat = 16
        }

        struct HTML {
            static let boldWeight = 600
            static let spacing = 16
        }
    }

    struct Fonts {
        static let body = UIFont.systemFont(ofSize: Styles.Sizes.Text.body)
        static let bodyBold = UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.body)
        static let secondary = UIFont.systemFont(ofSize: Styles.Sizes.Text.secondary)
        static let title = UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.title)
        static let button = UIFont.systemFont(ofSize: Styles.Sizes.Text.button)
        static let headline = UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.headline)
        static let smallTitle = UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.smallTitle)
        static let code = UIFont(name: "Courier", size: Styles.Sizes.Text.body)!
    }

    struct Colors {
        static let green = "28a745"
        static let red = "cb2431"
        static let background = "ffffff"

        struct Blue {
            static let medium = "0366d6"
            static let light = "f1f8ff"
        }

        struct Gray {
            static let dark = "24292e"
            static let medium = "586069"
            static let light = "a3aab1"
            static let lighter = "f6f8fa"
            static let border = "bcbbc1"

            static let alphaLighter = UIColor(white: 0, alpha: 0.10)
        }
    }

}

extension String {
    var color: UIColor {
        return UIColor.fromHex(self)
    }
}

