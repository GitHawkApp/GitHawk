//
//  SpinnerTableCell.swift
//  Freetime
//
//  Created by Ehud Adler on 11/9/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

final class SpinnerTableCell: StyledTableCell {

    private let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    private var indicatorHolder: UITableViewCellAccessoryType?

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(activity)
        activity.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.trailing.equalTo(self).inset(20)
        }
        activity.hidesWhenStopped = true
    }

    func startSpinner() {
        indicatorHolder = self.accessoryType
        self.accessoryType = .none
        activity.startAnimating()
    }
    func stopSpinner() {
        activity.stopAnimating()
        self.accessoryType = indicatorHolder ?? .none
    }
}
