//
//  RepositoryReadmeSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledTextKit

final class RepositoryReadmeSectionController: ListSwiftSectionController<RepositoryReadmeModel> {

    private lazy var webviewCache: WebviewCellHeightCache = {
        return WebviewCellHeightCache(sectionController: self)
    }()
    private lazy var imageCache: ImageCellHeightCache = {
        return ImageCellHeightCache(sectionController: self)
    }()
    private lazy var photoHandler: PhotoViewHandler = {
        return PhotoViewHandler(viewController: self.viewController)
    }()

    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: Styles.Sizes.gutter, bottom: 0, right: Styles.Sizes.gutter)
    }

    override func createBinders(from value: RepositoryReadmeModel) -> [ListBinder] {
        let inset = self.inset
        return value.models.compactMap {
            if let model = $0 as? IssueCommentImageModel {
                return binder(
                    model,
                    cellType: ListCellType.class(IssueCommentImageCell.self),
                    size: { [imageCache] context in
                        let width = context.collection.containerSize.width - inset.left - inset.right
                        return CGSize(
                            width: width,
                            height: imageCache.height(model: context.value, width: width)
                        )
                    },
                    configure: { [imageCache, photoHandler] (cell, context) in
                        cell.delegate = photoHandler
                        cell.heightDelegate = imageCache
                        cell.configure(with: context.value)
                })
            } else if let model = $0 as? IssueCommentCodeBlockModel {
                return binder(
                    model,
                    cellType: ListCellType.class(IssueCommentCodeBlockCell.self),
                    size: { context in
                        let width = context.collection.containerSize.width - inset.left - inset.right
                        let inset = IssueCommentCodeBlockCell.scrollViewInset
                        return CGSize(
                            width: width,
                            height: context.value.contentSize.height + inset.top + inset.bottom
                        )
                    },
                    configure: {
                        $0.configure(with: $1.value)
                })
            } else if let model = $0 as? IssueCommentSummaryModel {
                return binder(
                    model,
                    cellType: ListCellType.class(IssueCommentSummaryCell.self),
                    size: { context in
                        let width = context.collection.containerSize.width - inset.left - inset.right
                        return CGSize(
                            width: width,
                            height: Styles.Sizes.tableCellHeight
                        )
                },
                    configure: {
                        $0.configure(with: $1.value)
                })
            } else if let model = $0 as? IssueCommentQuoteModel {
                return binder(
                    model,
                    cellType: ListCellType.class(IssueCommentQuoteCell.self),
                    size: { context in
                        let width = context.collection.containerSize.width - inset.left - inset.right
                        return CGSize(
                            width: width,
                            height: context.value.string.viewSize(in: width).height
                        )
                },
                    configure: {
                        $0.configure(with: $1.value)
                })
            } else if let model = $0 as? IssueCommentHtmlModel {
                return binder(
                    model,
                    cellType: ListCellType.class(IssueCommentHtmlCell.self),
                    size: { [webviewCache] context in
                        let width = context.collection.containerSize.width - inset.left - inset.right
                        return CGSize(
                            width: width,
                            height: webviewCache.height(model: context.value, width: width)
                        )
                },
                    configure: { [webviewCache, viewController, photoHandler] (cell, context) in
                        cell.delegate = webviewCache
                        cell.navigationDelegate = viewController
                        cell.imageDelegate = photoHandler
                        cell.configure(with: context.value)
                })
            } else if let model = $0 as? IssueCommentHrModel {
                return binder(
                    model,
                    cellType: ListCellType.class(IssueCommentHrCell.self),
                    size: { context in
                        let width = context.collection.containerSize.width - inset.left - inset.right
                        return CGSize(
                            width: width,
                            height: 3.0 + IssueCommentHrCell.inset.top + IssueCommentHrCell.inset.bottom
                        )
                })
            } else if let model = $0 as? StyledTextRenderer {
                return binder(
                    model,
                    cellType: ListCellType.class(IssueCommentTextCell.self),
                    size: { context in
                        let width = context.collection.containerSize.width - inset.left - inset.right
                        return CGSize(
                            width: width,
                            height: context.value.viewSize(in: width).height
                        )
                    },
                    configure: { [viewController] (cell, context) in
                        cell.textView.tapDelegate = viewController
                        cell.configure(with: context.value)
                })
            } else if let model = $0 as? IssueCommentTableModel {
                return binder(
                    model,
                    cellType: ListCellType.class(IssueCommentTableCell.self),
                    size: { context in
                        let width = context.collection.containerSize.width - inset.left - inset.right
                        return CGSize(
                            width: width,
                            height: context.value.size.height
                        )
                    },
                    configure: { [viewController] (cell, context) in
                        cell.delegate = viewController
                        cell.configure(with: context.value)
                })
            }
            return nil
        }
    }

}
