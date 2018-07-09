//
//  IssueCommentDetailCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit
import SDWebImage
import DateAgo

protocol IssueCommentDetailCellDelegate: class {
    func didTapMore(cell: IssueCommentDetailCell, sender: UIView)
    func didTapProfile(cell: IssueCommentDetailCell)
}

final class IssueCommentDetailCell: IssueCommentBaseCell, ListBindable {

    weak var delegate: IssueCommentDetailCellDelegate?

    private let imageView = UIImageView()
    private let loginLabel = UILabel()
    private let dateLabel = ShowMoreDetailsLabel()
    private let editedLabel = ShowMoreDetailsLabel()
    private let moreButton = UIButton()
    private var login = ""

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.configureForAvatar()
        imageView.isUserInteractionEnabled = true
        imageView.accessibilityIgnoresInvertColors = true
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(IssueCommentDetailCell.onTapAvatar))
        )
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(Styles.Sizes.avatar)
            make.left.equalTo(Styles.Sizes.commentGutter)
            make.top.equalTo(Styles.Sizes.rowSpacing)
        }

        loginLabel.font = Styles.Text.title.preferredFont
        loginLabel.textColor = Styles.Colors.Gray.dark.color
        loginLabel.isUserInteractionEnabled = true
        loginLabel.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(IssueCommentDetailCell.onTapLoginLabel))
        )
        contentView.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.centerY)
            make.left.equalTo(imageView.snp.right).offset(Styles.Sizes.columnSpacing)
        }

        dateLabel.font = Styles.Text.secondary.preferredFont
        dateLabel.textColor = Styles.Colors.Gray.light.color
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(loginLabel)
            make.top.equalTo(loginLabel.snp.bottom)
        }

        moreButton.setImage(UIImage(named: "bullets")?.withRenderingMode(.alwaysTemplate), for: .normal)
        moreButton.contentVerticalAlignment = .center
        moreButton.contentHorizontalAlignment = .right
        moreButton.imageView?.contentMode = .center
        moreButton.tintColor = Styles.Colors.Gray.light.color
        moreButton.addTarget(self, action: #selector(IssueCommentDetailCell.onMore(sender:)), for: .touchUpInside)
        moreButton.accessibilityLabel = Constants.Strings.moreOptions
        contentView.addSubview(moreButton)
        moreButton.snp.makeConstraints { make in
            make.size.equalTo(Styles.Sizes.buttonMin)
            make.centerY.equalTo(imageView)
            make.right.equalTo(-Styles.Sizes.commentGutter)
        }

        editedLabel.font = Styles.Text.secondary.preferredFont
        editedLabel.textColor = Styles.Colors.Gray.light.color
        contentView.addSubview(editedLabel)
        editedLabel.snp.makeConstraints { make in
            make.left.equalTo(dateLabel.snp.right).offset(Styles.Sizes.inlineSpacing)
            make.centerY.equalTo(dateLabel)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func setBorderVisible(_ visible: Bool) {
        border = visible ? .head : .neck
    }

    // MARK: Private API

    @objc func onMore(sender: UIButton) {
        delegate?.didTapMore(cell: self, sender: sender)
    }

    @objc func onTapAvatar() {
        delegate?.didTapProfile(cell: self)
    }

    @objc func onTapLoginLabel() {
        delegate?.didTapProfile(cell: self)
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentDetailsViewModel else { return }

        backgroundColor = viewModel.didAuthor
            ? Styles.Colors.Blue.light.color
            : .white

        imageView.sd_setImage(with: viewModel.avatarURL)
        dateLabel.setText(date: viewModel.date)
        loginLabel.text = viewModel.login

        if let editedLogin = viewModel.editedBy, let editedDate = viewModel.editedAt {
            editedLabel.isHidden = false

            let editedByNonOwner = NSLocalizedString("Edited by %@", comment: "")
            let editedByOwner = NSLocalizedString("Edited", comment: "")
            let format = viewModel.login != editedLogin ? editedByNonOwner : editedByOwner
            editedLabel.text = "\(Constants.Strings.bullet) \(String(format: format, editedLogin))"

            let detailFormat = NSLocalizedString("%@ edited this issue %@", comment: "")
            editedLabel.detailText = String(format: detailFormat, arguments: [editedLogin, editedDate.agoString(.long)])
        } else {
            editedLabel.isHidden = true
        }
    }

}
