//
//  NotificationDetailsCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

protocol NotificationCellDelegate: class {
    func didTapMark(cell: NotificationCell)
}

final class NotificationCell: UICollectionViewCell {

    weak var delegate: NotificationCellDelegate? = nil

    static let labelInset = UIEdgeInsets(
        top: Styles.Sizes.icon.height + Styles.Sizes.rowSpacing,
        left: Styles.Sizes.gutter,
        bottom: 0,
        right: Styles.Sizes.gutter
    )

    let reasonImageView = UIImageView()
    let markButton = UIButton(type: .custom)
    let dateLabel = ShowMoreDetailsLabel()
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        reasonImageView.backgroundColor = .clear
        reasonImageView.contentMode = .scaleAspectFit
        contentView.addSubview(reasonImageView)
        reasonImageView.snp.makeConstraints { make in
            make.size.equalTo(Styles.Sizes.icon)
            make.left.equalTo(Styles.Sizes.gutter)
            make.top.equalTo(0)
        }

        markButton.backgroundColor = .clear
        markButton.imageView?.contentMode = .scaleAspectFit
        markButton.setImage(UIImage(named: "check"), for: .normal)
        contentView.addSubview(markButton)
        markButton.snp.makeConstraints { make in
            make.size.equalTo(Styles.Sizes.buttonIcon)
            make.right.equalTo(-Styles.Sizes.gutter)
            make.centerY.equalTo(reasonImageView)
        }

        dateLabel.backgroundColor = .clear
        dateLabel.font = Styles.Fonts.secondary
        dateLabel.textColor = Styles.Colors.Gray.light
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(reasonImageView.snp.right).offset(Styles.Sizes.columnSpacing)
            make.centerY.equalTo(reasonImageView)
        }

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(NotificationCell.labelInset)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

fileprivate let dateFormatter = DateFormatter()

extension NotificationCell: IGListBindable {

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? NotificationViewModel else { return }
        markButton.isHidden = viewModel.read
        titleLabel.attributedText = viewModel.title
        dateLabel.text = viewModel.date.agoString
        reasonImageView.image = viewModel.type.icon

        dateFormatter.dateFormat = "yyyy-MM-dd HH:ss ZZZ"
        dateLabel.detailText = dateFormatter.string(from: viewModel.date)

        setNeedsLayout()
    }

}
