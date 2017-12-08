//
//  LabelListView.swift
//  Freetime
//
//  Created by Joe Rocca on 12/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

class LabelListView: UIView, UICollectionViewDataSource {
    
    var labels = [RepositoryLabel]()
    
    let collectionView: UICollectionView = {
        let layout = WrappingStaticSpacingFlowLayout(estimatedItemSize: CGSize(width: 40, height: Styles.Sizes.labelRowHeight),
                                                     interitemSpacing: Styles.Sizes.labelSpacing,
                                                     rowSpacing: Styles.Sizes.labelSpacing)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(LabelListCell.self, forCellWithReuseIdentifier: LabelListCell.reuse)
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    
    // MARK: Public API
    
    func configure(labels: [RepositoryLabel]) {
        self.labels = labels
        collectionView.reloadData()
    }
}
