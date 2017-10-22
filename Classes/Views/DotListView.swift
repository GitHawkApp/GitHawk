//
//  DotView.swift
//  Freetime
//
//  Created by Joe Rocca on 10/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

class DotListView: UIView, UICollectionViewDataSource {
    
    private let collectionView: UICollectionView
    private var colors = [UIColor]()
    
    init(frame: CGRect = .zero,
         dotSize: CGSize = CGSize(width: 10, height: 10)) {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = dotSize
        layout.minimumLineSpacing = Styles.Sizes.columnSpacing / 2.0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isUserInteractionEnabled = false
        collectionView.register(IssueLabelDotCell.self, forCellWithReuseIdentifier: IssueLabelDotCell.reuse)
        
        super.init(frame: frame)
        
        collectionView.dataSource = self
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { fatalError("Missing layout") }
        let max = Int(bounds.width / (layout.itemSize.width + layout.minimumLineSpacing))
        return colors.count <= max ? colors.count : max
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IssueLabelSummaryCell.reuse, for: indexPath)
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    // MARK: Public API
    
    func configure(colors: [UIColor]) {
        self.colors = colors
        collectionView.reloadData()
    }
}
