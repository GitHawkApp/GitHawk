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

final class IssueStatusCell: UICollectionViewCell, ListBindable {

    let button = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        button.setupAsLabel()
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.gutter)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueStatusModel else { return }

        button.config(pullRequest: viewModel.pullRequest, state: viewModel.status.buttonState)

        let title: String
        switch viewModel.status {
        case .closed: title = Strings.closed
        case .open: title = Strings.open
        case .merged: title = Strings.merged
        }
        button.setTitle(title, for: .normal)
    }

}
