//
//  IssueLabelStatusCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/26/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

final class IssueLabelStatusCell: UICollectionViewCell, ListBindable {

    private static let font = Styles.Text.title.preferredFont

    static func size(_ string: String) -> CGSize {
        return string.size(
            font: font,
            xPadding: (Styles.Sizes.icon.width + Styles.Sizes.rowSpacing/2)/2,
            yPadding: 2
        )
    }

    private let imageView = UIImageView()
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
        contentView.addSubview(label)

        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        label.font = IssueLabelStatusCell.font
        label.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(Styles.Sizes.inlineSpacing)
            make.centerY.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        if let viewModel = viewModel as? IssueLabelStatusModel {
            let color: UIColor
            let icon: String
            switch viewModel.status {
            case .closed:
                color = Styles.Colors.Red.medium.color
                icon = viewModel.pullRequest ? "git-pull-request" : "issue-closed"
            case .open:
                color = Styles.Colors.Green.medium.color
                icon = viewModel.pullRequest ? "git-pull-request" : "issue-opened"
            case .merged:
                color = Styles.Colors.purple.color
                icon = "git-merge"
            }
            label.text = viewModel.status.title
            label.textColor = color
            imageView.tintColor = color
            imageView.image = UIImage(named: "\(icon)-small")?.withRenderingMode(.alwaysTemplate)
        } else if let viewModel = viewModel as? String {
            let tint = Styles.Colors.Gray.dark.color
            label.text = viewModel
            label.textColor = tint
            imageView.tintColor = tint
            imageView.image = UIImage(named: "lock-small").withRenderingMode(.alwaysTemplate)
        }
    }

}
