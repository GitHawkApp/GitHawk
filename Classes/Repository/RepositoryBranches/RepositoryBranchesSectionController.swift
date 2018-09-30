//
//  RepoBranchesSectionController.swift
//  Freetime
//
//  Created by B_Litwin on 9/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol RepositoryBranchSectionControllerDelegate: class {
    func didSelect(value: RepositoryBranchViewModel)
}

final class RepositoryBranchSectionController: ListSwiftSectionController<RepositoryBranchViewModel> {
    
    public weak var delegate: RepositoryBranchSectionControllerDelegate?
    
    override func createBinders(from value: RepositoryBranchViewModel) -> [ListBinder] {
        return [
            binder(
                value,
                cellType: ListCellType.class(RepositoryBranchCell.self),
                size: {
                    return CGSize(
                        width: $0.collection.containerSize.width,
                        height: Styles.Sizes.tableCellHeightLarge
                    )
            },
                configure: {
                    $0.label.text = $1.value.branch
                    $0.setSelected($1.value.selected)
            },
                didSelect: { [weak self] context in
                    guard let strongSelf = self else { return }
                    context.deselect(animated: true)
                    strongSelf.delegate?.didSelect(value: context.value)
            })
        ]
    }
}

