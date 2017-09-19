//
//  ProjectColumnCell.swift
//  Freetime
//
//  Created by Sherlock, James on 19/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class ProjectColumnCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var feed: Feed?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        accessibilityTraits |= UIAccessibilityTraitButton
//        isAccessibilityElement = true
        
        contentView.backgroundColor = .white
        
        titleLabel.numberOfLines = 1
        titleLabel.font = Styles.Fonts.body
        titleLabel.textColor = Styles.Colors.Gray.dark.color
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.gutter)
            make.right.equalTo(-Styles.Sizes.gutter)
            make.height.equalTo(40)
        }
        
        titleLabel.addBorder(.bottom, left: -Styles.Sizes.gutter, right: Styles.Sizes.gutter)
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0))
        }
        
        layer.cornerRadius = 5
        layer.borderColor = Styles.Colors.Gray.border.color.cgColor
        layer.borderWidth = 1 / UIScreen.main.scale
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ model: Project.Details.Column, viewController: UIViewController, feedDelegate: FeedDelegate) {
        feed = Feed(viewController: viewController, delegate: feedDelegate, collectionView: collectionView, managesLayout: false)
        titleLabel.text = model.name
    }
    
//    override var accessibilityLabel: String? {
//        get {
//            return contentView.subviews
//                .flatMap { $0.accessibilityLabel }
//                .reduce("", { $0 + ".\n" + $1 })
//        }
//        set { }
//    }
    
}
