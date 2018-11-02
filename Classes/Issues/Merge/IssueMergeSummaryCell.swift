//
//  IssueMergeSummaryCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 2/11/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

final class IssueMergeSummaryCell: CardCollectionViewCell, ListBindable {

    private let imageView = UIImageView()
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        isAccessibilityElement = true

        contentView.addSubview(imageView)
        contentView.addSubview(label)

//        imageView.clipsToBounds = true
//        imageView.tintColor = .white
//        imageView.layer.cornerRadius = Styles.Sizes.avatar.width / 2
//        imageView.contentMode = .center
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
//            make.size.equalTo(Styles.Sizes.avatar)
            make.left.equalTo(Styles.Sizes.cardGutter)
        }

        label.textColor = Styles.Colors.Gray.dark.color
        label.font = Styles.Text.bodyBold.preferredFont
        label.lineBreakMode = .byTruncatingMiddle
        label.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(Styles.Sizes.columnSpacing)
            make.centerY.equalToSuperview()
            make.right.lessThanOrEqualToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueMergeSummaryModel else { return }

        label.text = viewModel.title

        let imageViewBackground: UIColor
        let iconName: String
        switch viewModel.state {
        case .success:
            imageViewBackground = Styles.Colors.Green.medium.color
            iconName = "merge-check"
        case .failure:
            imageViewBackground = Styles.Colors.Red.medium.color
            iconName = "merge-x"
        case .pending:
            imageViewBackground = Styles.Colors.Yellow.medium.color
            iconName = "primitive-dot"
        case .warning:
            imageViewBackground = Styles.Colors.Gray.medium.color
            iconName = "merge-alert"
        }
//        imageView.backgroundColor = imageViewBackground
        imageView.tintColor = imageViewBackground
        imageView.image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
        accessibilityLabel = .localizedStringWithFormat("%@. (state: %@)", viewModel.title, viewModel.state.description)
    }

}
