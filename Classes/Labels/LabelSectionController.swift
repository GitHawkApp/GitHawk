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

    override func createViewModelData(value: RepositoryLabel) -> [BindingData] {
        return [
            bindingData(value, cellType: LabelCell2.self, size: {
                return CGSize(
                    width: $0.collectionContext.containerSize.width,
                    height: Styles.Sizes.tableCellHeight
                )
            })
        ]
    }

    override func didSelectItem(at index: Int) {
        collectionContext?.deselectItem(at: index, sectionController: self, animated: true)
    }

}
