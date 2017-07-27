//
//  IssueNeckLoadSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/27/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

protocol IssueNeckLoadSectionControllerDelegate: class {
    func didSelect(sectionController: IssueNeckLoadSectionController)
}

final class IssueNeckLoadSectionController: ListSectionController {

    private weak var delegate: IssueNeckLoadSectionControllerDelegate?
    private var loadingOverride = false

    init(delegate: IssueNeckLoadSectionControllerDelegate) {
        self.delegate = delegate
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Collection context must be set") }
        return CGSize(width: width, height: Styles.Sizes.tableCellHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueNeckLoadCell.self, for: self, at: index) as? IssueNeckLoadCell
            else { fatalError("Missing collection context, cell incorrect type, or object missing") }
        cell.configure(loading: loadingOverride)
        return cell
    }

    override func didSelectItem(at index: Int) {
        delegate?.didSelect(sectionController: self)
        collectionContext?.performBatch(animated: true, updates: { context in
            self.loadingOverride = true
            context.reload(self)
        })
    }

}
