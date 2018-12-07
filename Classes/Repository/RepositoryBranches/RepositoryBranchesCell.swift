//
//  RepoBranchesCell.swift
//  Freetime
//
//  Created by B_Litwin on 9/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

final class RepositoryBranchCell: SelectableCell {
    public let label = UILabel()
    private let checkedImageView = UIImageView(image: UIImage(named: "check-small").withRenderingMode(.alwaysTemplate))

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = nil
        contentView.backgroundColor = nil

        contentView.addSubview(checkedImageView)
        checkedImageView.tintColor = Styles.Colors.Blue.medium.color
        checkedImageView.snp.makeConstraints { make in
            make.right.equalTo(-Styles.Sizes.gutter)
            make.centerY.equalTo(contentView.snp.centerY)
        }

        contentView.addSubview(label)
        label.font = Styles.Text.bodyBold.preferredFont
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.right.lessThanOrEqualTo(checkedImageView.snp.left)
            make.centerY.equalTo(contentView.snp.centerY)
        }

        let border = contentView.addBorder(.bottom,
                                           left: Styles.Sizes.gutter,
                                           right: -Styles.Sizes.gutter
        )
        border.backgroundColor = Styles.Colors.Gray.medium.color
    }

    func setSelected(_ selected: Bool) {
        checkedImageView.isHidden = !selected
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Accessibility

    override var accessibilityLabel: String? {
        get { return AccessibilityHelper.generatedLabel(forCell: self) }
        set { }
    }
}
