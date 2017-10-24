//
//  SegmentedControlCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol SegmentedControlCellDelegate: class {
    func didChangeSelection(cell: SegmentedControlCell, index: Int)
}

final class SegmentedControlCell: UICollectionViewCell {

    weak var delegate: SegmentedControlCellDelegate?

    private let segmentedControl = UISegmentedControl(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        segmentedControl.addTarget(self, action: #selector(SegmentedControlCell.didSelect(sender:)), for: .valueChanged)
        contentView.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.right.equalTo(Styles.Sizes.gutter)
            make.centerY.equalTo(contentView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(items: [String]) {
        segmentedControl.removeAllSegments()
        for (i, item) in items.enumerated() {
            segmentedControl.insertSegment(withTitle: item, at: i, animated: false)
        }
    }

    // MARK: Private API

    @objc private func didSelect(sender: Any) {
        delegate?.didChangeSelection(cell: self, index: segmentedControl.selectedSegmentIndex)
    }

}
