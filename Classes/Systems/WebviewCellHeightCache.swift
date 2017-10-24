//
//  WebviewCellHeightCache.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class WebviewCellHeightCache: IssueCommentHtmlCellDelegate {

    private static let cache = WidthCache<String, CGSize>()
    private weak var sectionController: ListSectionController?

    init(sectionController: ListSectionController) {
        self.sectionController = sectionController
    }

    // MARK: Public API

    func height(model: IssueCommentHtmlModel, width: CGFloat) -> CGFloat {
        return WebviewCellHeightCache.cache.data(key: model.html, width: width)?.height
            ?? Styles.Sizes.tableCellHeight
    }

    // MARK: IssueCommentHtmlCellDelegate

    func webViewDidResize(cell: IssueCommentHtmlCell, html: String, cellWidth: CGFloat, size: CGSize) {
        guard let sectionController = self.sectionController,
            sectionController.section != NSNotFound,
            size != WebviewCellHeightCache.cache.data(key: html, width: cellWidth)
            else { return }

        WebviewCellHeightCache.cache.set(data: size, key: html, width: cellWidth)

        UIView.performWithoutAnimation {
            sectionController.collectionContext?.invalidateLayout(for: sectionController)
        }
    }

}
