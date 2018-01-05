//
//  MilestoneCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class MilestoneCell: UITableViewCell {

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!

    // MARK: Public API

    func configure(title: String, date: Date?, showCheckmark: Bool) {
        self.titleLabel.text = title
        if let date = date {
            let format = NSLocalizedString("Due by %@", comment: "")
            dueDateLabel.text = String(format: format, MilestoneCell.dateFormatter.string(from: date))
        } else {
            dueDateLabel.text = NSLocalizedString("No due date", comment: "")
        }
        accessoryType = showCheckmark ? .checkmark : .none
    }

}
