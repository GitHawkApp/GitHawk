//
//  NotificationDetailsCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol NotificationDetailsCellDelegate: class {
    func didTapMark(cell: NotificationDetailsCell)
}

final class NotificationDetailsCell: UICollectionViewCell {

    weak var delegate: NotificationDetailsCellDelegate? = nil

    fileprivate let reasonImageView = UIImageView()
    fileprivate let markButton = UIButton(type: .custom)
    fileprivate let dateLabel = UILabel()

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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

extension NotificationDetailsCell: IGListBindable {

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? NotificationDetailsViewModel else { return }
        markButton.isHidden = viewModel.read
    }

}
