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
        // only fetch and show cells if this unit hasn't been shown
        guard controller.hasDisplayedLatest == false else { return }
        // never show again for this app version
        // network failure acceptable in case of skipped release notes
        controller.hasDisplayedLatest = true

        controller.fetch { [weak self] result in
            switch result {
            case .success(let markdown):
                self?.markdown = markdown
                self?.update()
            case .error(let error):
                print(error?.localizedDescription ?? "Error updating new features")
            }
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
            title: controller.version,
            asMenu: true
        ))
    }

    // MARK: NewFeaturesCellDelegate

    func didTapClose(for cell: NewFeaturesCell) {
        closed = true
        update()
    }

}
