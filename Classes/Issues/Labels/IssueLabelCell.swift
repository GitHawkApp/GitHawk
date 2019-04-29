//
//  IssueLabelCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

final class IssueLabelCell: UICollectionViewCell, ListBindable {

    let background = UIView()
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        background.layer.cornerRadius = Styles.Sizes.avatarCornerRadius
        contentView.addSubview(background)
        background.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.right.equalTo(-Styles.Sizes.gutter)
            make.top.equalTo(0)
            make.bottom.equalTo(-Styles.Sizes.rowSpacing)
        }

        label.font = Styles.Text.smallTitle.preferredFont
        background.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(background)
            make.left.equalTo(Styles.Sizes.columnSpacing)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentView()
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? RepositoryLabel else { return }
        let color = UIColor.fromHex(viewModel.color)
        background.backgroundColor = color
        label.text = viewModel.name
        label.textColor = color.textOverlayColor
    }

}
