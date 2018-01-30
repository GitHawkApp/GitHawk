//
//  IssueReviewEmptyTailCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueReviewEmptyTailCell: IssueCommentBaseCell, ListBindable {

    override init(frame: CGRect) {
        super.init(frame: frame)
        border = .tail
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {}
}
