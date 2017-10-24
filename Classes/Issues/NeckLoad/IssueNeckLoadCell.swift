//
//  IssueNeckLoadCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/27/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueNeckLoadCell: SelectableCell {

    private let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.text = NSLocalizedString("Load More", comment: "")
        label.textColor = Styles.Colors.Blue.medium.color
        label.font = Styles.Fonts.secondaryBold
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }

        activity.hidesWhenStopped = true
        contentView.addSubview(activity)
        activity.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(loading: Bool) {
        label.isHidden = loading
        if loading {
            activity.startAnimating()
        } else {
            activity.stopAnimating()
        }
    }

}
