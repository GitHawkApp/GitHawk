//
//  File.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/21/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import IGListKit

final class LabelSectionController: ListSwiftSectionController<RepositoryLabel> {

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
                configure: { [selected] in
                    let color = $1.value.color.color
                    $0.button.setTitleColor(color.textOverlayColor, for: .normal)
                    $0.button.backgroundColor = color
                    $0.button.setTitle($1.value.name, for: .normal)

                    $0.setSelected(selected)
                },
                didSelect: { [weak self] context in
                    guard let strongSelf = self else { return }
                    strongSelf.selected = !strongSelf.selected
                    context.deselect()
                    context.cell?.setSelected(strongSelf.selected)
            })
        ]
    }

}

