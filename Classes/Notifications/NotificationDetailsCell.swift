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

    private let reasonImageView = UIImageView()
    private let markButton = UIButton(type: .custom)
    private let dateLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        reasonImageView.backgroundColor = .clear
        contentView.addSubview(reasonImageView)

        markButton.backgroundColor = .clear
        contentView.addSubview(markButton)

        dateLabel.backgroundColor = .clear
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
    }

}
