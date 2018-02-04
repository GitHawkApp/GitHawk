//
//  IssueDiffHunkPathCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/3/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueDiffHunkPathCell: UICollectionViewCell, ListBindable {

    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = Styles.Colors.Gray.lighter.color

        label.adjustsFontSizeToFitWidth = true
        label.textColor = Styles.Colors.Gray.dark.color
        label.font = Styles.Text.code.preferredFont
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.commentGutter)
            make.width.lessThanOrEqualTo(contentView).offset(-Styles.Sizes.commentGutter * 2)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? String else { return }
        label.text = viewModel
    }

}
