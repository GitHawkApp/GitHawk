//
//  LoadMoreSectionController2.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/21/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class LoadMoreSectionController2: ListSwiftSectionController<String> {

    override func createViewModelData(value: String) -> [BindingData] {
        return [
            bindingData(value, cellType: LoadMoreCell.self, size: {
                return CGSize(
                    width: $0.collectionContext.containerSize.width,
                    height: Styles.Sizes.tableCellHeight
                )
            })
        ]
    }

}
