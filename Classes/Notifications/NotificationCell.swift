//
//  NotificationDetailsCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol NotificationCellDelegate: class {
    func didTapMark(cell: NotificationCell)
}

final class NotificationCell: UICollectionViewCell {

    weak var delegate: NotificationCellDelegate? = nil

    let reasonImageView = UIImageView()
    let markButton = UIButton(type: .custom)
    let dateLabel = UILabel()
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        reasonImageView.backgroundColor = .clear
        contentView.addSubview(reasonImageView)

        markButton.backgroundColor = .clear
        contentView.addSubview(markButton)

        dateLabel.backgroundColor = .clear
        dateLabel.font = Styles.Fonts.secondary
        dateLabel.textColor = Styles.Colors.Gray.light
        contentView.addSubview(dateLabel)

        titleLabel.font = Styles.Fonts.body
        titleLabel.textColor = Styles.Colors.Gray.dark
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

extension NotificationCell: IGListBindable {

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? NotificationViewModel else { return }
        markButton.isHidden = viewModel.read
        titleLabel.text = viewModel.title
        setNeedsLayout()
    }

}
