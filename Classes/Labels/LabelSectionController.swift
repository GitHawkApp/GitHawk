//
//  File.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/21/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import IGListKit

protocol LabelSectionControllerDelegate: class {
    func didSelect(controller: LabelSectionController)
}

final class LabelSectionController: ListSwiftSectionController<RepositoryLabel> {

    public weak var delegate: LabelSectionControllerDelegate?

    public private(set) var selected: Bool

    init(selected: Bool) {
        self.selected = selected
        super.init()
    }

    override func createBinders(from value: RepositoryLabel) -> [ListBinder] {
        return [
            binder(
                value,
                cellType: ListCellType.class(LabelMenuCell.self),
                size: {
                    return CGSize(
                        width: $0.collection.containerSize.width,
                        height: Styles.Sizes.tableCellHeightLarge
                    )
            },
                configure: { [weak self] in
                    let color = $1.value.color.color
                    $0.button.setTitleColor(color.textOverlayColor, for: .normal)
                    $0.button.backgroundColor = color
                    $0.button.setTitle($1.value.name, for: .normal)

                    $0.setSelected(self?.selected == true)
                },
                didSelect: { [weak self] context in
                    guard let strongSelf = self else { return }
                    strongSelf.selected = !strongSelf.selected
                    context.deselect()
                    context.cell?.setSelected(strongSelf.selected)
                    strongSelf.delegate?.didSelect(controller: strongSelf)
            })
        ]
    }

}

