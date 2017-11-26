//
//  IssueLabelSummaryCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

final class IssueLabelSummaryCell: UICollectionViewCell, ListBindable {

    static let reuse = "cell"

    private let label = UILabel()
    private let labelDotView = DotListView(dotSize: CGSize(width: 15, height: 15))
    private var colors = [UIColor]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true

        label.font = Styles.Fonts.secondary
        label.textColor = Styles.Colors.Gray.light.color
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.gutter)
        }

        contentView.addSubview(labelDotView)
        labelDotView.snp.makeConstraints { make in
            make.left.equalTo(label.snp.right).offset(Styles.Sizes.columnSpacing)
            make.top.bottom.right.equalTo(contentView)
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
        guard let viewModel = viewModel as? IssueLabelSummaryModel else { return }
        label.text = viewModel.title
        labelDotView.configure(colors: viewModel.colors)
    }

    // MARK: Accessibility
    override var accessibilityLabel: String? {
        get {
            return AccessibilityHelper.generatedLabel(forCell: self)
        }
        set { }
    }

}
