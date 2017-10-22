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

final class IssueLabelSummaryCell: UICollectionViewCell, UICollectionViewDataSource, ListBindable {

    static let reuse = "cell"

    private let label = UILabel()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 15, height: 15)
        layout.minimumLineSpacing = Styles.Sizes.columnSpacing / 2.0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(IssueLabelDotCell.self, forCellWithReuseIdentifier: IssueLabelSummaryCell.reuse)
        return view
    }()
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

        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = false
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
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

        let height = contentView.bounds.height
        let size = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize ?? .zero
        let inset = (height - size.height)/2
        collectionView.contentInset = UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IssueLabelSummaryCell.reuse, for: indexPath)
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueLabelSummaryModel else { return }
        label.text = viewModel.title
        colors = viewModel.colors
        collectionView.reloadData()
        setNeedsLayout()
    }
    
    // MARK: - Accessibility
    override var accessibilityLabel: String? {
        get {
            return contentView.subviews
                .flatMap { $0.accessibilityLabel }
                .reduce("", { "\($0 ?? "").\n\($1)" })
        }
        set { }
    }

}
