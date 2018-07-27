//
//  IssueMergeContextCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 2/11/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit
import SDWebImage

final class IssueMergeContextCell: CardCollectionViewCell, ListBindable {

    private let avatarView = UIImageView()
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        isAccessibilityElement = true

        contentView.addSubview(avatarView)
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)

        avatarView.clipsToBounds = true
        avatarView.layer.cornerRadius = Styles.Sizes.avatarCornerRadius
        avatarView.accessibilityIgnoresInvertColors = true
        avatarView.snp.makeConstraints { make in
            make.size.equalTo(Styles.Sizes.icon)
            make.centerY.equalToSuperview()
            make.left.equalTo(Styles.Sizes.cardGutter)
        }

        titleLabel.font = Styles.Text.secondaryBold.preferredFont
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarView.snp.right).offset(Styles.Sizes.columnSpacing)
            make.centerY.equalToSuperview().offset(-Styles.Sizes.rowSpacing)
        }

        descriptionLabel.font = Styles.Text.secondary.preferredFont
        descriptionLabel.textColor = Styles.Colors.Gray.light.color
        descriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom)
        }

        iconView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-Styles.Sizes.cardGutter)
        }

        backgroundColor = Styles.Colors.Gray.lighter.color
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueMergeContextModel else { return }

        avatarView.sd_setImage(with: viewModel.avatarURL)
        titleLabel.text = viewModel.context
        descriptionLabel.text = viewModel.description

        let iconName: String
        let iconColor: UIColor
        switch viewModel.state {
        case .success, .expected:
            iconName = "check-small"
            iconColor = Styles.Colors.Green.medium.color
        case .error, .failure, .__unknown:
            iconName = "x-small"
            iconColor = Styles.Colors.Red.medium.color
        case .pending:
            iconName = "primitive-dot"
            iconColor = Styles.Colors.Yellow.medium.color
        }
        iconView.image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = iconColor

        let stateString = viewModel.state.rawValue.lowercased()
        accessibilityLabel = .localizedStringWithFormat("Status for %@: %@. Context: %@.", viewModel.context, stateString, viewModel.description)
    }

}
