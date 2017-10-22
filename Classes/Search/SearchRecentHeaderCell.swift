//
//  SearchRecentHeaderCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol SearchRecentHeaderCellDelegate: class {
    func didSelectClear(cell: SearchRecentHeaderCell)
}

final class SearchRecentHeaderCell: UICollectionViewCell {

    weak var delegate: SearchRecentHeaderCellDelegate? = nil

    private let label = UILabel()
    private let button = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.text = NSLocalizedString("Recent Searches", comment: "").uppercased(with: Locale.current)
        label.font = Styles.Fonts.secondary
        label.textColor = Styles.Colors.Gray.light.color
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.centerY.equalTo(contentView)
        }

        button.setTitle(Constants.Strings.clearAll, for: .normal)
        button.setTitleColor(Styles.Colors.Blue.medium.color, for: .normal)
        button.titleLabel?.font = Styles.Fonts.button
        button.addTarget(self, action: #selector(SearchRecentHeaderCell.onClear), for: .touchUpInside)
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
        layoutContentViewForSafeAreaInsets()
    }

    // MARK: Private API

    @objc
    func onClear() {
        delegate?.didSelectClear(cell: self)
    }

}
