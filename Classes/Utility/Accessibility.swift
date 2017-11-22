//
//  Accessibility.swift
//  Freetime
//
//  Created by Bas Thomas Broek on 22/11/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

private protocol ContentViewContaining {
    var contentView: UIView { get }
}

extension UICollectionViewCell: ContentViewContaining {}
extension UITableViewCell: ContentViewContaining {}

enum AccessibilityHelper {

    static func generatedLabel(forCell cell: UICollectionViewCell) -> String {
        return generatedLabel(forContentViewContainer: cell)
    }

    static func generatedLabel(forCell cell: UITableViewCell) -> String {
        return generatedLabel(forContentViewContainer: cell)
    }
}

private extension AccessibilityHelper {
    static func generatedLabel(forContentViewContainer cell: ContentViewContaining) -> String {
        return cell.contentView.subviews
            .flatMap { $0.accessibilityLabel }
            .reduce("") { "\($0).\n\($1)" }
    }
}
