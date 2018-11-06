//
//  RepositoryCodeDirectorySectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

protocol RepositoryCodeDirectorySectionControllerDelegate: class {
    func didSelect(
        controller: RepositoryCodeDirectorySectionController,
        path: String,
        isDirectory: Bool
    )
}

final class RepositoryCodeDirectorySectionController: ListSwiftSectionController<RepositoryFile> {

    private weak var delegate: RepositoryCodeDirectorySectionControllerDelegate?

    init(delegate: RepositoryCodeDirectorySectionControllerDelegate?) {
        self.delegate = delegate
        super.init()
    }

    override func createBinders(from value: RepositoryFile) -> [ListBinder] {
        return [
            binder(value, cellType: ListCellType.class(RepositoryFileCell.self), size: {
                return CGSize(
                    width: $0.collection.containerSize.width,
                    height: Styles.Sizes.tableCellHeight
                )
            }, configure: {
                $0.configure(path: $1.value.name, isDirectory: $1.value.isDirectory)
            }, didSelect: { [weak self] context in
                guard let `self` = self else { return }
                self.delegate?.didSelect(
                    controller: self,
                    path: context.value.name,
                    isDirectory: context.value.isDirectory
                )
            })
        ]
    }
    
}
