//
//  LabelListView.swift
//  Freetime
//
//  Created by Joe Rocca on 12/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class LabelListView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    static func height(width: CGFloat, labels: [RepositoryLabel], cacheKey: String) -> CGFloat {
        if let cachedHeight = LabelListViewHeightCache.shared.height(forKey: cacheKey) {
            return cachedHeight
        }
        
        let rowHeight = LabelListCell.size(labels.first?.name ?? "").height
        var labelTextTotalWidth = CGFloat()
        for label in labels {
            labelTextTotalWidth += LabelListCell.size(label.name).width
        }
        let interitemSpacing = labels.count > 1 ? CGFloat(labels.count - 1) * Styles.Sizes.labelSpacing : 0.0
        labelTextTotalWidth += interitemSpacing
        let labelRows = ceil(labelTextTotalWidth / width)
        let rowSpacing = labelRows > 1 ? (labelRows - 1) * Styles.Sizes.labelSpacing : 0.0
        
        let height = ceil((rowHeight * labelRows) + rowSpacing)
        LabelListViewHeightCache.shared.store(height: height, forKey: cacheKey)
        
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
        collectionView.isUserInteractionEnabled = false
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
    
    func configure(labels: [RepositoryLabel]) {
        self.labels = labels
        collectionView.reloadData()
    }
}
