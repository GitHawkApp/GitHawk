//
//  PathCommitSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/20/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class PathCommitSectionController: ListSwiftSectionController<PathCommitModel> {

    override func createBinders(from value: PathCommitModel) -> [ListBinder] {
        return [
            binder(
                value,
                cellType: ListCellType.class(PathCommitCell.self),
                size: {
                    return CGSize(
                        width: $0.collection.containerSize.width,
                        height: $0.value.text.viewSize(in: $0.collection.insetContainerSize.width).height
                    )
            },
                configure: {
                    $0.configure(with: $1.value)
            },
                didSelect: { [weak self] context in
                    guard let `self` = self else { return }
                    context.deselect(animated: true)
                    self.viewController?.presentSafari(url: context.value.commitURL)
            })
        ]
    }

}
