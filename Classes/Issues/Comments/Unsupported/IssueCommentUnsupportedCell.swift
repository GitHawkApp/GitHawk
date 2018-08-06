//
//  IssueCommentUnsupportedCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

final class IssueCommentUnsupportedCell: IssueCommentBaseCell, ListBindable {

    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .red

        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentUnsupportedModel else { return }
        label.text = viewModel.name
    }

}
