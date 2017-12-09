//
//  IssueLabelsSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueLabelsSectionController: ListBindingSectionController<IssueLabelsModel>,
ListBindingSectionControllerDataSource {

    private var sizeCache = [String: CGSize]()

    override init() {
        super.init()
        minimumInteritemSpacing = Styles.Sizes.labelSpacing
        minimumLineSpacing = Styles.Sizes.labelSpacing
        inset = UIEdgeInsets(top: 0, left: Styles.Sizes.gutter, bottom: 0, right: Styles.Sizes.gutter)
        dataSource = self
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        viewModelsFor object: Any
        ) -> [ListDiffable] {
        return self.object?.labels ?? []
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {
        guard let viewModel = viewModel as? RepositoryLabel
            else { fatalError("Collection context must be set") }

        let key = viewModel.name

        if let size = sizeCache[key] {
            return size
        }

        let size = LabelListCell.size(key)
        sizeCache[key] = size
        return size
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell & ListBindable {
        guard let cell = collectionContext?.dequeueReusableCell(of: LabelListCell.self, for: self, at: index) as? LabelListCell
            else { fatalError("Missing context or wrong cell") }
        return cell
    }
}

