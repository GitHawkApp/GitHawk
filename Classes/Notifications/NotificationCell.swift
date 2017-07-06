//
//  NotificationDetailsCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import SwipeCellKit

final class NotificationCell: SwipeCollectionViewCell {

    static let labelInset = UIEdgeInsets(
        top: Styles.Fonts.title.lineHeight + 2*Styles.Sizes.rowSpacing,
        left: Styles.Sizes.icon.width + 2*Styles.Sizes.columnSpacing,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter
    )

    private let reasonImageView = UIImageView()
    private let dateLabel = ShowMoreDetailsLabel()
    private let titleLabel = UILabel()
    private let textLabel = UILabel()
    private let selectionOverlay = CALayer()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white

        titleLabel.numberOfLines = 1
        titleLabel.font = Styles.Fonts.title
        titleLabel.textColor = Styles.Colors.Gray.light.color
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(Styles.Sizes.rowSpacing)
            make.left.equalTo(NotificationCell.labelInset.left)
        }

        dateLabel.backgroundColor = .clear
        dateLabel.numberOfLines = 1
        dateLabel.font = Styles.Fonts.secondary
        dateLabel.textColor = Styles.Colors.Gray.light.color
        dateLabel.textAlignment = .right
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.right.equalTo(-Styles.Sizes.gutter)
            make.centerY.equalTo(titleLabel)
        }

        reasonImageView.backgroundColor = .clear
        reasonImageView.contentMode = .scaleAspectFit
        reasonImageView.tintColor = Styles.Colors.Blue.medium.color
        contentView.addSubview(reasonImageView)
        reasonImageView.snp.makeConstraints { make in
            make.size.equalTo(Styles.Sizes.icon)
            make.top.equalTo(NotificationCell.labelInset.top)
            make.left.equalTo(Styles.Sizes.rowSpacing)
        }

        textLabel.numberOfLines = 0
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(NotificationCell.labelInset)
        }

        addBorder(left: NotificationCell.labelInset.left)

        selectionOverlay.backgroundColor = Styles.Colors.Gray.alphaLighter.cgColor
        selectionOverlay.opacity = 0
        contentView.layer.addSublayer(selectionOverlay)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        selectionOverlay.frame = contentView.bounds
    }

    override var isSelected: Bool {
        didSet {
            showOverlay(show: isSelected)
        }
    }

    override var isHighlighted: Bool {
        didSet {
            showOverlay(show: isHighlighted)
        }
    }

    // MARK: Public API

    var isRead = false {
        didSet {
            for view in [titleLabel, textLabel, reasonImageView] {
                view.alpha = isRead ? 0.5 : 1
            }
        }
    }

    func configure(_ viewModel: NotificationViewModel) {
        var titleAttributes = [
            NSFontAttributeName: Styles.Fonts.title,
            NSForegroundColorAttributeName: Styles.Colors.Gray.light.color
        ]
        let title = NSMutableAttributedString(string: "\(viewModel.owner)/\(viewModel.repo) ", attributes: titleAttributes)

        titleAttributes[NSFontAttributeName] = Styles.Fonts.secondary
        switch viewModel.identifier {
        case .number(let number): title.append(NSAttributedString(string: "\(number)", attributes: titleAttributes))
        default: break
        }
        titleLabel.attributedText = title

        textLabel.attributedText = viewModel.title.attributedText
        dateLabel.setText(date: viewModel.date)
        reasonImageView.image = viewModel.type.icon?.withRenderingMode(.alwaysTemplate)
    }

    // MARK: Private API

    private func showOverlay(show: Bool) {
        selectionOverlay.opacity = show ? 1 : 0
    }

}
