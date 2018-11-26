//
//  LoadMoreSectionController.swift
//  Freetime
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

protocol LoadMoreSectionControllerDelegate: class {
    func didSelect(sectionController: LoadMoreSectionController)
}

final class LoadMoreSectionController: ListSectionController {

    private weak var delegate: LoadMoreSectionControllerDelegate?
    private var loadingOverride = false

    init(delegate: LoadMoreSectionControllerDelegate) {
        self.delegate = delegate
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return collectionContext.cellSize(with: Styles.Sizes.tableCellHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: LoadMoreCell.self, for: self, at: index) as? LoadMoreCell else {
            fatalError("Missing context, or cell is wrong type")
        }
        cell.configure(loading: loadingOverride)
        return cell
    }

    override func didSelectItem(at index: Int) {
        delegate?.didSelect(sectionController: self)
        collectionContext?.performBatch(animated: trueUnlessReduceMotionEnabled, updates: { context in
            self.loadingOverride = true
            context.reload(self)
        })
    }

}
