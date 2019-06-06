//
//  SearchRecentHeaderCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol ClearAllHeaderCellDelegate: class {
    func didSelectClear(cell: ClearAllHeaderCell)
}

final class ClearAllHeaderCell: UICollectionViewCell {

    weak var delegate: ClearAllHeaderCellDelegate?

    private let label = UILabel()
    private let button = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = Styles.Colors.Gray.lighter.color

        label.font = Styles.Text.secondary.preferredFont
        label.textColor = Styles.Colors.Gray.medium.color
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.centerY.equalTo(contentView)
        }

        button.setTitle(Constants.Strings.clearAll, for: .normal)
        button.setTitleColor(Styles.Colors.Blue.medium.color, for: .normal)
        button.titleLabel?.font = Styles.Text.button.preferredFont
        button.addTarget(self, action: #selector(ClearAllHeaderCell.onClear), for: .touchUpInside)
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.right.equalTo(-Styles.Sizes.gutter)
            make.centerY.equalTo(label)
        }

        addBorder(.bottom, useSafeMargins: false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentView()
    }

    func configure(title text: String) {
        label.text = text
    }

    // MARK: Private API

    @objc func onClear() {
        delegate?.didSelectClear(cell: self)
    }

}
