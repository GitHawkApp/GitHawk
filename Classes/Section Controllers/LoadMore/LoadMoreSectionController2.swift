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

private struct LoadMoreModel: ListSwiftDiffable {
    let loading: Bool

    var identifier: String {
        return "loading"
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        guard let value = value as? LoadMoreModel else { return false }
        return loading == value.loading
    }
}

final class LoadMoreSectionController2: ListSwiftSectionController<String> {

    weak var delegate: LoadMoreSectionController2Delegate?
    private var loading = false

    override func createBinders(from value: String) -> [ListBinder] {
        return [
            binder(
                LoadMoreModel(loading: loading),
                cellType: ListCellType.class(LoadMoreCell.self),
                size: {
                    return CGSize(
                        width: $0.collection.containerSize.width,
                        height: Styles.Sizes.tableCellHeight
                    )

            },
                configure: {
                    $0.configure(loading: $1.value.loading)
            },
                didSelect: { [weak self] _ in
                    guard let strongSelf = self else { return }
                    strongSelf.loading = true
                    strongSelf.delegate?.didSelect(controller: strongSelf)
                    strongSelf.update()
            })
        ]
    }

}
