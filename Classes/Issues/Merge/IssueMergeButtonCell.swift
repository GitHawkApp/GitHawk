//
//  IssueMergeButtonCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 2/11/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

final class IssueMergeButtonCell: IssueCommentBaseCell, ListBindable {

    var delegate: MergeButtonDelegate? {
        get { return mergeButton.delegate }
        set { mergeButton.delegate = newValue }
    }

    private let mergeButton = MergeButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(mergeButton)

        mergeButton.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(
                top: Styles.Sizes.rowSpacing/2,
                left: Styles.Sizes.commentGutter,
                bottom: Styles.Sizes.rowSpacing,
                right: Styles.Sizes.commentGutter
            ))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueMergeButtonModel else { return }

        let title: String
        switch viewModel.type {
        case .merge: title = NSLocalizedString("Merge pull request", comment: "")
        case .squash: title = NSLocalizedString("Squash and merge", comment: "")
        case .rebase: title = NSLocalizedString("Rebase and merge", comment: "")
        }
        mergeButton.configure(title: title, enabled: viewModel.enabled)
    }
    
}
