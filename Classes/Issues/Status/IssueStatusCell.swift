//
//  IssueStatusCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

final class IssueStatusCell: UICollectionViewCell, IGListBindable {

    let button = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        button.tintColor = .white
        button.titleLabel?.font = Styles.Fonts.smallTitle
        button.layer.cornerRadius = Styles.Sizes.avatarCornerRadius
        button.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -Styles.Sizes.columnSpacing, bottom: 0, right: 0)
        button.contentEdgeInsets = UIEdgeInsets(top: 2, left: Styles.Sizes.columnSpacing + 2, bottom: 2, right: 4)
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.gutter)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: IGListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueStatusModel else { return }
        let title: String
        let color: UIColor
        let iconName: String
        let prName = "git-pull-request-small"
        if viewModel.closed {
            title = Strings.closed
            color = Styles.Colors.red
            iconName = viewModel.pullRequest ? "issue-closed-small" : prName
        } else {
            title = Strings.open
            color = Styles.Colors.green
            iconName = viewModel.pullRequest ? "issue-opened-small" : prName
        }
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.backgroundColor = color
    }

}
