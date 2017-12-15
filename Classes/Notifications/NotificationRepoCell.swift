//
//  NotificationRepoCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

final class NotificationRepoCell: UICollectionViewCell, ListBindable {

    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = Styles.Colors.Gray.lighter.color

        label.font = Styles.Text.title.preferredFont
        label.textColor = Styles.Colors.Gray.light.color
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.centerY.equalTo(self.contentView)
        }

        contentView.addBorder(.bottom)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? String else { return }
        label.text = viewModel
    }

}
