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

    private let buttonBackgroundView = UIView()
    private let mergeButton = UIButton()
    private let optionButton = UIButton()
    private let optionBorder = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(buttonBackgroundView)
        buttonBackgroundView.addSubview(mergeButton)
        buttonBackgroundView.addSubview(optionButton)
        buttonBackgroundView.addSubview(optionBorder)

        buttonBackgroundView.layer.cornerRadius = Styles.Sizes.avatarCornerRadius
        buttonBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(
                top: Styles.Sizes.rowSpacing/2,
                left: Styles.Sizes.commentGutter,
                bottom: Styles.Sizes.rowSpacing,
                right: Styles.Sizes.commentGutter
            ))
        }

        optionButton.setImage(UIImage(named: "chevron-down")?.withRenderingMode(.alwaysTemplate), for: .normal)
        optionButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-Styles.Sizes.gutter)
        }

        mergeButton.titleLabel?.font = Styles.Text.bodyBold.preferredFont
        mergeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-Styles.Sizes.gutter-10)
        }

        optionBorder.alpha = 0.6
        optionBorder.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Styles.Sizes.rowSpacing/2)
            make.bottom.equalToSuperview().offset(-Styles.Sizes.rowSpacing/2)
            make.width.equalTo(1/UIScreen.main.scale)
            make.right.equalTo(optionButton.snp.left).offset(-Styles.Sizes.gutter)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueMergeButtonModel else { return }

        buttonBackgroundView.backgroundColor = viewModel.enabled
            ? Styles.Colors.Green.medium.color
            : Styles.Colors.Gray.light.color
        buttonBackgroundView.alpha = viewModel.enabled ? 1 : 0.3
        optionButton.isEnabled = viewModel.enabled
        mergeButton.isEnabled = viewModel.enabled

        let titleColor = viewModel.enabled ? .white : Styles.Colors.Gray.dark.color
        mergeButton.setTitleColor(titleColor, for: .normal)
        optionButton.tintColor = titleColor
        optionBorder.backgroundColor = titleColor

        let title: String
        switch viewModel.type {
        case .merge: title = NSLocalizedString("Merge pull request", comment: "")
        case .squash: title = NSLocalizedString("Squash and merge", comment: "")
        case .rebase: title = NSLocalizedString("Rebase and merge", comment: "")
        }
        mergeButton.setTitle(title, for: .normal)
    }
    
}
