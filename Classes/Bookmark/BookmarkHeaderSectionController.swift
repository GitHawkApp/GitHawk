//
//  BookmarkHeaderSectionController.swift
//  Freetime
//
//  Created by Hesham Salman on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

protocol BookmarkHeaderSectionControllerDelegate: class {
    func didTapClear(sectionController: BookmarkHeaderSectionController)
}

final class BookmarkHeaderSectionController: ListSwiftSectionController<String>, ClearAllHeaderCellDelegate {

    weak var delegate: BookmarkHeaderSectionControllerDelegate?

    init(delegate: BookmarkHeaderSectionControllerDelegate?) {
        self.delegate = delegate
        super.init()
    }

    override func createBinders(from value: String) -> [ListBinder] {
        return [
            binder(
                value,
                cellType: ListCellType.class(ClearAllHeaderCell.self),
                size: {
                    return $0.collection.cellSize(with: Styles.Sizes.tableCellHeight)
            }, configure: { [weak self] (cell, _) in
                cell.delegate = self
                cell.configure(title: Constants.Strings.bookmarks.uppercased(with: Locale.current))
            })
        ]
    }

    // MARK: ClearAllHeaderCellDelegate

    func didSelectClear(cell: ClearAllHeaderCell) {
        let alert = UIAlertController.configured(
            title: NSLocalizedString("Clear All Bookmarks", comment: ""),
            message: NSLocalizedString(
                "Are you sure you want to clear your bookmarks? This will erase bookmarks on other devices.",
                comment: ""
            ),
            preferredStyle: .alert
        )

        alert.addActions([
            AlertAction.clearAll { [weak self] _ in
                guard let `self` = self else { return }
                self.delegate?.didTapClear(sectionController: self)
            },
            AlertAction.cancel()
            ])

        viewController?.present(alert, animated: true)
    }
}
