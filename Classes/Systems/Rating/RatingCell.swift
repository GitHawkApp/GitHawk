//
//  RatingCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol RatingCellDelegate: class {
    func didTapDismiss(cell: RatingCell)
}

final class RatingCell: UICollectionViewCell {

    weak var delegate: RatingCellDelegate?

    private let titleLabel = UILabel()
    private let detailLabel = UILabel()
    private let dismissButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = Styles.Colors.Blue.medium.color

        let tint = UIColor.white

        titleLabel.textAlignment = .center
        titleLabel.font = Styles.Text.bodyBold.preferredFont
        titleLabel.textColor = tint
        titleLabel.text = NSLocalizedString("Enjoying GitHawk? 😍", comment: "")
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.centerY).offset(-Styles.Sizes.rowSpacing*2)
            make.centerX.equalTo(contentView)
        }

        detailLabel.textAlignment = .center
        detailLabel.font = Styles.Text.body.preferredFont
        detailLabel.textColor = tint
        detailLabel.numberOfLines = 0
        detailLabel.text = NSLocalizedString("Help spread the word by leaving\na quick rating & review!", comment: "")
        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(contentView).offset(-Styles.Sizes.gutter*2)
            make.top.equalTo(titleLabel.snp.bottom).offset(Styles.Sizes.rowSpacing)
            make.centerX.equalTo(contentView)
        }

        dismissButton.setImage(UIImage(named: "x")?.withRenderingMode(.alwaysTemplate), for: .normal)
        dismissButton.tintColor = tint
        dismissButton.addTarget(self, action: #selector(RatingCell.onDismiss), for: .touchUpInside)
        contentView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.top.equalTo(Styles.Sizes.rowSpacing)
            make.right.equalTo(-Styles.Sizes.gutter)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
    }

    // MARK: Private API

    @objc func onDismiss() {
        delegate?.didTapDismiss(cell: self)
    }

}
