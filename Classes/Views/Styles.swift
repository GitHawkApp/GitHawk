//
//  Layout.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

enum Styles {

    enum Sizes {
        static let gutter: CGFloat = 15
        static let eventGutter: CGFloat = 8
        static let icon = CGSize(width: 20, height: 20)
        static let buttonMin = CGSize(width: 44, height: 44)
        static let buttonIcon = CGSize(width: 25, height: 25)
        static let barButton = CGRect(x: 0, y: 0, width: 30, height: 44)
        static let avatarCornerRadius: CGFloat = 3
        static let labelCornerRadius: CGFloat = 2
        static let columnSpacing: CGFloat = 8
        static let rowSpacing: CGFloat = 8
        static let cellSpacing: CGFloat = 15
        static let tableCellHeight: CGFloat = 44
        static let tableCellHeightLarge: CGFloat = 55
        static let tableSectionSpacing: CGFloat = 35
        static let avatar = CGSize(width: 30, height: 30)
        static let inlineSpacing: CGFloat = 4
        static let listInsetLarge = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        static let listInsetLargeHead = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        static let listInsetLargeTail = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        static let listInsetTight = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        static let textCellInset = UIEdgeInsets(
            top: 0,
            left: Styles.Sizes.gutter,
            bottom: Styles.Sizes.rowSpacing,
            right: Styles.Sizes.gutter
        )
        static let textViewInset = UIEdgeInsets(
            top: Styles.Sizes.rowSpacing,
            left: Styles.Sizes.gutter,
            bottom: Styles.Sizes.rowSpacing,
            right: Styles.Sizes.gutter
        )
        static let labelEventHeight: CGFloat = 30
        static let labelRowHeight: CGFloat = 18
        static let labelSpacing: CGFloat = 4
        static let labelTextPadding: CGFloat = 4
        
        enum Text {

            private static func size(
                _ base: CGFloat,
                minSize: CGFloat = 0,
                maxSize: CGFloat = CGFloat.greatestFiniteMagnitude
                ) -> CGFloat {
                let multiplier: CGFloat
                // https://github.com/mapbox/mapbox-navigation-ios/blob/master/MapboxNavigation/UIFont.swift#L8-L19
                switch UIApplication.shared.preferredContentSizeCategory {
                case .accessibilityExtraExtraExtraLarge: multiplier = 23 / 16
                case .accessibilityExtraExtraLarge: multiplier = 22 / 16
                case .accessibilityExtraLarge: multiplier = 21 / 16
                case .accessibilityLarge: multiplier = 20 / 16
                case .accessibilityMedium: multiplier = 19 / 16
                case .extraExtraExtraLarge: multiplier = 19 / 16
                case .extraExtraLarge: multiplier = 18 / 16
                case .extraLarge: multiplier = 17 / 16
                case .large: multiplier = 1
                case .medium: multiplier = 15 / 16
                case .small: multiplier = 14 / 16
                case .extraSmall: multiplier = 13 / 16
                default: multiplier = 1
                }
                let result = base * multiplier
                return min(max(result, minSize), maxSize)
            }

            static var body: CGFloat { return size(16) }
            static var secondary: CGFloat { return size(13) }
            static var title: CGFloat { return size(14) }
            static var button: CGFloat { return size(16) }
            static var headline: CGFloat { return size(18) }
            static var smallTitle: CGFloat { return size(12) }
            static var h1: CGFloat { return size(24) }
            static var h2: CGFloat { return size(22) }
            static var h3: CGFloat { return size(20) }
            static var h4: CGFloat { return size(18) }
            static var h5: CGFloat { return size(16) }
            static var h6: CGFloat { return size(16) }
            static var code: CGFloat { return size(14) }

        }

        enum HTML {
            static let boldWeight = 600
            static let spacing = 16
        }
    }

    enum Fonts {
        static let body = UIFont.systemFont(ofSize: Styles.Sizes.Text.body)
        static let bodyBold = UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.body)
        static let bodyItalic = UIFont.italicSystemFont(ofSize: Styles.Sizes.Text.body)
        static let secondary = UIFont.systemFont(ofSize: Styles.Sizes.Text.secondary)
        static let secondaryBold = UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.secondary)
        static let title = UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.title)
        static let button = UIFont.systemFont(ofSize: Styles.Sizes.Text.button)
        static let headline = UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.headline)
        static let smallTitle = UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.smallTitle)
        static let code = UIFont(name: "Courier", size: Styles.Sizes.Text.body)!
        static let secondaryCode = UIFont(name: "Courier", size: Styles.Sizes.Text.secondary)!
    }

    enum Colors {

        static let background = Styles.Colors.Gray.lighter.color
        static let purple = "6f42c1"
        static let blueGray = "8697af"

        enum Red {
            static let medium = "cb2431"
            static let light = "ffeef0"
        }

        enum Green {
            static let medium = "28a745"
            static let light = "e6ffed"
        }

        enum Blue {
            static let medium = "0366d6"
            static let light = "f1f8ff"
        }

        enum Gray {
            static let dark = "24292e"
            static let medium = "586069"
            static let light = "a3aab1"
            static let lighter = "f6f8fa"
            static let border = "bcbbc1"

            static let alphaLighter = UIColor(white: 0, alpha: 0.10)
        }

        enum Yellow {
            static let medium = "f29d50"
            static let light = "fff5b1"
        }

    }

    static func setupAppearance() {
        UINavigationBar.appearance().tintColor =  Styles.Colors.Blue.medium.color
        UINavigationBar.appearance().titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color]
    }

}

extension String {

    public var color: UIColor {
        return UIColor.fromHex(self)
    }

}
