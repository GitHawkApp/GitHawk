//
//  IssueViewFilesCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/11/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class IssueViewFilesCell: UICollectionViewCell {

    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.centerY.equalTo(contentView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(changes: FileChanges) {
        let attributedText = NSMutableAttributedString()

        let actionFormat = NSLocalizedString("View Files (%zi) ", comment: "")
        attributedText.append(NSAttributedString(
            string: .localizedStringWithFormat(actionFormat, changes.changedFiles),
            attributes: [
                .font: Styles.Text.secondary.preferredFont,
                .foregroundColor: Styles.Colors.Blue.medium.color
            ]
        ))
        if changes.additions > 0 {
            attributedText.append(NSAttributedString(
                string: "+\(changes.additions) ", // note trailing space
                attributes: [
                    .font: Styles.Text.secondaryBold.preferredFont,
                    .foregroundColor: Styles.Colors.Green.medium.color
                ]
            ))
        }
        if changes.deletions > 0 {
            attributedText.append(NSAttributedString(
                string: "-\(changes.deletions)",
                attributes: [
                    .font: Styles.Text.secondaryBold.preferredFont,
                    .foregroundColor: Styles.Colors.Red.medium.color
                ]
            ))
        }
        label.attributedText = attributedText
    }

}
