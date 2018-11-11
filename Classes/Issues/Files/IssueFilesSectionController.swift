//
//  IssueFilesSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueFilesSectionController: ListSwiftSectionController<File> {

    override func createBinders(from value: File) -> [ListBinder] {
        return [
            binder(value, cellType: ListCellType.class(IssueFileCell.self), size: {
                return CGSize(
                    width: $0.collection.insetContainerSize.width,
                    height: Styles.Sizes.tableCellHeightLarge
                )
            }, configure: {
                $0.configure(
                    path: $1.value.filename,
                    additions: $1.value.additions.intValue,
                    deletions: $1.value.deletions.intValue,
                    disclosureHidden: $1.value.patch == nil
                )
            }, didSelect: { [weak self] context in
                guard let patch = context.value.patch else { return }
                let controller = IssuePatchContentViewController(
                    patch: patch,
                    fileName: context.value.actualFileName
                )
                self?.viewController?.show(controller, sender: nil)
            })
        ]
    }

}
