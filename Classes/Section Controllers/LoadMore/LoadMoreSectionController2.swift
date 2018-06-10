//
//  LoadMoreSectionController2.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/21/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol LoadMoreSectionController2Delegate: class {
    func didSelect(controller: LoadMoreSectionController2)
}

final class LoadMoreSectionController2: ListSwiftSectionController<String> {

    weak var delegate: LoadMoreSectionController2Delegate?

    override func createBinders(from value: String) -> [ListBinder] {
        return [
            binder(value, cellType: .class(LoadMoreCell.self), size: {
                return CGSize(
                    width: $0.collection.containerSize.width,
                    height: Styles.Sizes.tableCellHeight
                )
            }, didSelect: { [weak self] context in
                guard let strongSelf = self else { return }
                strongSelf.delegate?.didSelect(controller: strongSelf)
            })
        ]
    }

}
