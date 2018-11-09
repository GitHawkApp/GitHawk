//
//  SpinnerTableCell.swift
//  Freetime
//
//  Created by Ehud Adler on 11/9/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

final class SpinnerTableCell: StyledTableCell {

    let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var indicatorHolder: UITableViewCellAccessoryType?

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(activity)
        activity.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.trailing.equalTo(self).inset(20)
        }
        activity.hidesWhenStopped = true
    }

    public func showSpinner() {
        indicatorHolder = self.accessoryType
        self.accessoryType = .none
        activity.startAnimating()
    }
    public func stopSpinner() {
        activity.stopAnimating()
        self.accessoryType = indicatorHolder ?? .none
    }
}
