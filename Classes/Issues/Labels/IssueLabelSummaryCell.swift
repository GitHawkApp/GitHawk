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

    private let labelListView = LabelListView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true
        
        contentView.addSubview(labelListView)
        labelListView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(Styles.Sizes.gutter)
            make.right.equalTo(contentView).offset(-Styles.Sizes.gutter)
            make.top.equalTo(contentView).offset(Styles.Sizes.labelSpacing)
            make.bottom.equalTo(contentView).offset(-Styles.Sizes.labelSpacing)
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
        labelListView.configure(labels: viewModel.labels)
    }

    // MARK: Accessibility
    override var accessibilityLabel: String? {
        get {
            return AccessibilityHelper.generatedLabel(forCell: self)
        }
        set { }
    }

}
