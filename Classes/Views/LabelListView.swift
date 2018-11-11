//
//  LabelListView.swift
//  Freetime
//
//  Created by Joe Rocca on 12/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

protocol LabelListViewTapDelegate: class {
    func didTap(label: String)
}

final class LabelListView: UIView,
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout {

    private static var cache = [String: CGFloat]()
    private weak var tapDelegate: LabelListViewTapDelegate?

    static func height(width: CGFloat, labels: [RepositoryLabel], cacheKey: String) -> CGFloat {
        let key = "\(cacheKey)\(width)"
        if let cachedHeight = LabelListView.cache[key] {
            return cachedHeight
        }

        let rowHeight = LabelListCell.size(labels.first?.name ?? "").height
        let interitemSpacing = labels.count > 1 ? CGFloat(labels.count - 1) * Styles.Sizes.labelSpacing : 0.0
        let labelTextTotalWidth = labels.reduce(0, { $0 + LabelListCell.size($1.name).width }) + interitemSpacing
        let labelRows = ceil(labelTextTotalWidth / width)
        let rowSpacing = labelRows > 1 ? (labelRows - 1) * Styles.Sizes.labelSpacing : 0.0

        let height = ceil((rowHeight * labelRows) + rowSpacing)
        LabelListView.cache[key] = height

        return height
    }

    var labels = [RepositoryLabel]()

    let collectionView: UICollectionView = {
        let layout = WrappingStaticSpacingFlowLayout(interitemSpacing: Styles.Sizes.labelSpacing,
                                                     rowSpacing: Styles.Sizes.labelSpacing)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(LabelListCell.self, forCellWithReuseIdentifier: LabelListCell.reuse)
        collectionView.backgroundColor = UIColor.clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let lastCell = collectionView.cellForItem(at: [0, labels.count - 1])
            else { return self }
        return point.x > lastCell.frame.maxX ? self : super.hitTest(point, with: event)
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapDelegate?.didTap(label: labels[indexPath.row].name)
    }
    
    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelListCell.reuse, for: indexPath) as! LabelListCell
        let label = labels[indexPath.row]
        cell.configure(label: label)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = labels[indexPath.row]
        return LabelListCell.size(label.name)
    }

    // MARK: Public API

    func configure(labels: [RepositoryLabel], tapDelegate: LabelListViewTapDelegate?) {
        self.labels = labels
        self.tapDelegate = tapDelegate
        collectionView.reloadData()
    }
}
