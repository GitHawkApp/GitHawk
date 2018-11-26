//
//  MilestoneSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import IGListKit

protocol MilestoneSectionControllerDelegate: class {
    func didSelect(value: MilestoneViewModel, controller: MilestoneSectionController)
}

final class MilestoneSectionController: ListSwiftSectionController<MilestoneViewModel> {

    public weak var delegate: MilestoneSectionControllerDelegate?

    override func createBinders(from value: MilestoneViewModel) -> [ListBinder] {
        return [
            binder(
                value,
                cellType: ListCellType.class(MilestoneCell2.self),
                size: {
                    return $0.collection.cellSize(with: Styles.Sizes.tableCellHeightLarge)
            },
                configure: {
                    $0.label.text = $1.value.title
                    $0.detailLabel.text = $1.value.due
                    $0.setSelected($1.value.selected)
                },
                didSelect: { [weak self] context in
                    guard let strongSelf = self else { return }
                    context.deselect(animated: true)
                    strongSelf.delegate?.didSelect(value: context.value, controller: strongSelf)
            })
        ]
    }

}
