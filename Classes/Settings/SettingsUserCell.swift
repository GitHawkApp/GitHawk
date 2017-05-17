//
//  SettingsUserCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

final class SettingsUserCell: UICollectionViewCell {

    fileprivate let label = UILabel()
    fileprivate let accessoryView = UIImageView(image: UIImage(named: "check"))

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white

        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = Styles.Fonts.body
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.gutter)
        }

        accessoryView.backgroundColor = .clear
        accessoryView.contentMode = .scaleAspectFit
        contentView.addSubview(accessoryView)
        accessoryView.snp.makeConstraints { make in
            make.size.equalTo(Styles.Sizes.icon)
            make.right.equalTo(-Styles.Sizes.gutter)
            make.centerY.equalTo(contentView)
        }

        contentView.addBorder(bottom: true, left: Styles.Sizes.gutter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SettingsUserCell: IGListBindable {

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? SettingsUserModel else { return }
        label.text = viewModel.name
        accessoryView.isHidden = !viewModel.selected
    }

}
