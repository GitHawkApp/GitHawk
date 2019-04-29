//
//  NewFeaturesSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/22/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import ContextMenu

protocol NewFeaturesSectionControllerDelegate: class {
    func didTapClose(for sectionController: NewFeaturesSectionController)
}

final class NewFeaturesSectionController: ListSwiftSectionController<String>,
NewFeaturesCellDelegate {

    private weak var delegate: NewFeaturesSectionControllerDelegate?

    init(delegate: NewFeaturesSectionControllerDelegate?) {
        super.init()
        self.delegate = delegate
    }

    override func createBinders(from value: String) -> [ListBinder] {
        return [
            binder(
                value,
                cellType: ListCellType.class(NewFeaturesCell.self),
                size: {
                    return $0.collection.cellSize(
                        with: Styles.Sizes.tableCellHeight
                            + NewFeaturesCell.inset.top
                            + NewFeaturesCell.inset.bottom
                    )
            },
                configure: { [weak self] (cell, _) in
                    guard let `self` = self else { return }
                    cell.configure(with: NewFeaturesController.version)
                    cell.delegate = self
            },
                didSelect: { [weak self] context in
                    self?.showChanges(markdown: context.value)
            })
        ]
    }

    private func showChanges(markdown: String) {
        viewController?.showContextualMenu(IssuePreviewViewController(
            markdown: markdown,
            owner: "GitHawkApp",
            repo: "GitHawk",
            title: String.localizedStringWithFormat(
                NSLocalizedString("New in %@", comment: ""),
                NewFeaturesController.version
            ),
            asMenu: true
        ))
    }

    // MARK: NewFeaturesCellDelegate

    func didTapClose(for cell: NewFeaturesCell) {
        delegate?.didTapClose(for: self)
    }

}
