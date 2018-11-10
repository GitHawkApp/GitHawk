//
//  SearchRecentSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import SwipeCellKit

protocol SearchRecentSectionControllerDelegate: class {
    func didSelect(recentSectionController: SearchRecentSectionController, viewModel: SearchRecentViewModel)
    func didDelete(recentSectionController: SearchRecentSectionController, viewModel: SearchRecentViewModel)
}

// bridge to NSString for NSObject conformance
final class SearchRecentSectionController: ListGenericSectionController<SearchRecentViewModel>, SwipeCollectionViewCellDelegate {

    weak var delegate: SearchRecentSectionControllerDelegate?
    lazy var recentStore = SearchRecentStore()

    init(delegate: SearchRecentSectionControllerDelegate) {
        self.delegate = delegate
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return collectionContext.cellSize(
            with: Styles.Sizes.tableCellHeight + Styles.Sizes.rowSpacing * 2
        )
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: SearchRecentCell.self, for: self, at: index) as? SearchRecentCell
            else { fatalError("Missing context or wrong cell type") }
        cell.delegate = self
        cell.configure(viewModel: searchViewModel)
        return cell
    }

    override func didSelectItem(at index: Int) {
        collectionContext?.deselectItem(at: index, sectionController: self, animated: trueUnlessReduceMotionEnabled)
        delegate?.didSelect(recentSectionController: self, viewModel: searchViewModel)
    }

    // MARK: SwipeCollectionViewCellDelegate

    func collectionView(_ collectionView: UICollectionView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let action = DeleteSwipeAction { [weak self] _, _ in
            guard let strongSelf = self, let object = strongSelf.object else { return }
            strongSelf.delegate?.didDelete(recentSectionController: strongSelf, viewModel: object)
        }

        return [action]
    }

    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }

    // MARK: Private API

    var searchViewModel: SearchRecentViewModel {
        return object ?? SearchRecentViewModel(query: .search(""))
    }

}
