//
//  ContentWidthUtils.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

extension UICollectionViewCell {

    func layoutContentView(for safeAreaInsets: UIEdgeInsets? = nil) {
        let insets: UIEdgeInsets = safeAreaInsets ?? self.safeAreaInsets
        contentView.frame = CGRect(
            x: insets.left,
            y: bounds.minY,
            width: bounds.width - insets.left - insets.right,
            height: bounds.height
        )
    }

}

extension ListCollectionContext {

    // shortcut to create a cell size for a given height
    func cellSize(with height: CGFloat, inset: UIEdgeInsets = .zero) -> CGSize {
        return CGSize(width: cellWidth(with: inset), height: height)
    }

    // width of the CELL which shouldn't account for adjusted inset (e.g. notch)
    func cellWidth(with inset: UIEdgeInsets = .zero) -> CGFloat {
        return containerSize.width
            - (containerInset.left + containerInset.right)
            - (inset.left + inset.right)
    }

    // width of the CONTENT in a cell which should adjust insets (e.g. notch)
    func safeContentWidth(with inset: UIEdgeInsets = .zero) -> CGFloat {
        return insetContainerSize.width
            - (containerInset.left + containerInset.right)
            - (inset.left + inset.right)
    }

}

extension Optional where Wrapped == ListCollectionContext {

    func cellSize(with height: CGFloat, inset: UIEdgeInsets = .zero) -> CGSize {
        guard let `self` = self else { return .zero }
        return self.cellSize(with: height, inset: inset)
    }

    func cellWidth(with inset: UIEdgeInsets = .zero) -> CGFloat {
        return self?.cellWidth(with: inset) ?? 0
    }

    func safeContentWidth(with inset: UIEdgeInsets = .zero) -> CGFloat {
        return self?.safeContentWidth(with: inset) ?? 0
    }

}

extension UIView {

    func safeContentWidth(with collectionView: UICollectionView) -> CGFloat {
        let inset = collectionView.adjustedContentInset
        let frame = convert(collectionView.frame, from: collectionView)
        let width = bounds.width
        return width
            - (inset.left + inset.right)
            - (width - frame.width)
    }

}
