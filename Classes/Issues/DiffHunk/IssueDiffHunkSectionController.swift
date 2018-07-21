//
//  IssueDiffHunkSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/3/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledTextKit

final class IssueDiffHunkSectionController: ListBindingSectionController<IssueDiffHunkModel>, ListBindingSectionControllerDataSource {

    override init() {
        super.init()
        inset = Styles.Sizes.issueInset(bottom: 0)
        dataSource = self
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        viewModelsFor object: Any
        ) -> [ListDiffable] {
        guard let object = object as? IssueDiffHunkModel else { fatalError("Wrong model object") }
        return [
            object.path as ListDiffable,
            object.preview
        ]
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {
        let width = (collectionContext?.containerSize(for: self).width ?? 0)
        let height: CGFloat
        if let viewModel = viewModel as? StyledTextRenderer {
            height = viewModel.viewSize(in: 0).height
        } else {
            height = Styles.Sizes.labelEventHeight
        }
        return CGSize(width: width, height: height)
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell & ListBindable {
        guard let context = collectionContext
            else { fatalError("Collection context must be set") }
        let cellClass: AnyClass
        switch viewModel {
        case is String: cellClass = IssueDiffHunkPathCell.self
        case is StyledTextRenderer: cellClass = IssueDiffHunkPreviewCell.self
        default: fatalError("Unsupported model \(viewModel)")
        }
        guard let cell = context.dequeueReusableCell(of: cellClass, for: self, at: index) as? UICollectionViewCell & ListBindable
            else { fatalError("Cell not bindable") }
        return cell
    }

}
