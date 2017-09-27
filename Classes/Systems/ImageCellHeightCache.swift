//
//  ImageCellHeightCache.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class ImageCellHeightCache: IssueCommentImageHeightCellDelegate {

    private var sizes = [URL: CGSize]()
    private weak var sectionController: ListSectionController? = nil

    init(sectionController: ListSectionController) {
        self.sectionController = sectionController
    }

    // MARK: Public API

    func height(model: IssueCommentImageModel, width: CGFloat) -> CGFloat {
        guard let size = sizes[model.url] else { return 200 }
        let ratio = size.width / size.height
        return ceil(width / ratio)
    }

    // MARK: IssueCommentImageHeightCellDelegate

    func imageDidFinishLoad(cell: IssueCommentImageCell, url: URL, size: CGSize) {
        guard let sectionController = self.sectionController,
            sectionController.section != NSNotFound,
            size != sizes[url]
            else { return }

        sizes[url] = size

        // temporary hack until this PR lands
        // https://github.com/Instagram/IGListKit/pull/931

        let layout = (sectionController.collectionContext as! ListAdapter).collectionView?.collectionViewLayout
        layout?.invalidateLayout()
    }

}

