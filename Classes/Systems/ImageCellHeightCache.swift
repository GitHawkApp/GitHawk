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

    // width is unused since the full size of the image is stored
    private static let cache = WidthCache<URL, CGSize>()
    private weak var sectionController: ListSectionController?

    init(sectionController: ListSectionController) {
        self.sectionController = sectionController
    }

    // MARK: Public API

    func height(model: IssueCommentImageModel, width: CGFloat) -> CGFloat {
        guard let size = ImageCellHeightCache.cache.data(key: model.url, width: 0) else { return 200 }
        let ratio = size.width / size.height
        return ceil(width / ratio)
    }

    // MARK: IssueCommentImageHeightCellDelegate

    func imageDidFinishLoad(cell: IssueCommentImageCell, url: URL, size: CGSize) {
        guard let sectionController = self.sectionController,
            sectionController.section != NSNotFound,
            size != ImageCellHeightCache.cache.data(key: url, width: 0)
            else { return }

        ImageCellHeightCache.cache.set(data: size, key: url, width: 0)

        UIView.performWithoutAnimation {
            sectionController.collectionContext?.invalidateLayout(for: sectionController)
        }
    }

}
