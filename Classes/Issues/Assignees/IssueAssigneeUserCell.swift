//
//  IssueAssigneeUserCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit
import SDWebImage

final class IssueAssigneeUserCell: UICollectionViewCell, ListBindable {

    private let imageView = UIImageView()
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = Styles.Sizes.avatarCornerRadius
        imageView.layer.borderColor = Styles.Colors.Gray.light.color.cgColor
        imageView.layer.borderWidth = 1.0 / UIScreen.main.scale
        imageView.clipsToBounds = true
        if #available(iOS 11, *) {
            imageView.accessibilityIgnoresInvertColors = true
        }
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.gutter)
            make.size.equalTo(Styles.Sizes.icon)
        }

        label.font = Styles.Fonts.secondaryBold
        label.textColor = Styles.Colors.Gray.dark.color
        label.backgroundColor = .clear
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(imageView.snp.right).offset(Styles.Sizes.columnSpacing)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueAssigneeViewModel else { return }
        imageView.sd_setImage(with: viewModel.avatarURL)
        label.text = viewModel.login
    }
}
