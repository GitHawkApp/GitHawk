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

final class NewFeaturesSectionController: ListSwiftSectionController<String>,
NewFeaturesCellDelegate {

    private var markdown: String?
    private let controller = NewFeaturesController()
    private var closed = false

    override init() {
        super.init()
        controller.fetch { [weak self] markdown in
            self?.markdown = markdown
            self?.update()
        }
    }

    override func createBinders(from value: String) -> [ListBinder] {
        guard let markdown = self.markdown,
            closed == false
            else { return [] }
        return [
            binder(
                markdown,
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
                    cell.configure(with: self.controller.version)
                    cell.delegate = self
            },
                didSelect: { [weak self] _ in
                    self?.showChanges(markdown: markdown)
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
                controller.version
            ),
            asMenu: true
        ))
    }

    // MARK: NewFeaturesCellDelegate

    func didTapClose(for cell: NewFeaturesCell) {
        closed = true
        update()
    }

}
