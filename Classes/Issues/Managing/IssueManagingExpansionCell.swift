//
//  IssueManagingExpansionCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

final class IssueManagingExpansionCell: SelectableCell, ListBindable {

    private let label = UILabel()
    private let chevron = UIImageView(image: UIImage(named: "chevron-down-small")?.withRenderingMode(.alwaysTemplate))

    override init(frame: CGRect) {
        super.init(frame: frame)

        let tint = Styles.Colors.Blue.medium.color

        label.text = NSLocalizedString("Manage", comment: "")
        label.font = Styles.Fonts.secondaryBold
        label.textColor = tint
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.centerX.equalTo(contentView).offset(-Styles.Sizes.rowSpacing)
        }

        chevron.tintColor = tint
        contentView.addSubview(chevron)
        chevron.snp.makeConstraints { make in
            make.centerY.equalTo(label).offset(1)
            make.left.equalTo(label.snp.right).offset(Styles.Sizes.rowSpacing-3)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public API

    func animate(expanded: Bool) {
        UIView.animate(
            withDuration: (0.8),
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0,
            options: [],
            animations: {
                self.rotateChevron(expanded: expanded)
        })
    }

    // MARK: Private API

    private func rotateChevron(expanded: Bool) {
        chevron.transform = expanded ? CGAffineTransform(rotationAngle: CGFloat.pi) : .identity
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueManagingModel else { return }
        rotateChevron(expanded: viewModel.expanded)
    }

}
