//
//  IssueFilesTableCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class IssueFilesTableCell: StyledTableCell {

    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var pathLabel: UILabel!

    // MARK: Public API

    func configure(path: String, additions: Int, deletions: Int) {
        let changeString = NSMutableAttributedString()
        var attributes: [NSAttributedStringKey: Any] = [
            .font: Styles.Fonts.secondaryBold
        ]

        if additions > 0 {
            attributes[.foregroundColor] = Styles.Colors.Green.medium.color
            changeString.append(NSAttributedString(string: "+\(additions) ", attributes: attributes))
        }

        if deletions > 0 {
            attributes[.foregroundColor] = Styles.Colors.Red.medium.color
            changeString.append(NSAttributedString(string: "-\(deletions)", attributes: attributes))
        }

        changeLabel.attributedText = changeString

        pathLabel.text = path
    }

}
