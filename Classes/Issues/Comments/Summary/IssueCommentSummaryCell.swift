//
//  IssueCommentSummaryCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

final class IssueCommentSummaryCell: IssueCommentBaseCell, ListBindable {

    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.textColor = Styles.Colors.Gray.dark.color
        label.font = Styles.Text.body.preferredFont
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentSummaryModel else { return }
        configure(with: viewModel)
    }

    func configure(with model: IssueCommentSummaryModel) {
        label.text = "▶ \(model.summary)"
    }

}
