//
//  IssueReviewViewCommentsCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

protocol IssueReviewViewCommentsCellDelegate: class {
    func didTapViewComments(cell: IssueReviewViewCommentsCell)
}

final class IssueReviewViewCommentsCell: IssueCommentBaseCell, ListBindable {

    weak var delegate: IssueReviewViewCommentsCellDelegate? = nil

    private let button = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        button.setTitle(NSLocalizedString("View Comments", comment: ""), for: .normal)
        button.setTitleColor(Styles.Colors.Blue.medium.color, for: .normal)
        button.addTarget(self, action: #selector(IssueReviewViewCommentsCell.onButton), for: .touchUpInside)
        button.titleLabel?.font = Styles.Fonts.body
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.commentGutter)
            make.centerY.equalTo(contentView)
        }

        border = .tail
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
    }

    // MARK: Private API

    @objc func onButton() {
        delegate?.didTapViewComments(cell: self)
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {}

}
