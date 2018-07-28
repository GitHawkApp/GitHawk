//
//  PeopleSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/2/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import IGListKit

protocol PeopleSectionControllerDelegate: class {
    func didSelect(controller: PeopleSectionController)
}

final class PeopleSectionController: ListSwiftSectionController<IssueAssigneeViewModel> {

    public weak var delegate: PeopleSectionControllerDelegate?

    public private(set) var selected: Bool

    init(selected: Bool) {
        self.selected = selected
        super.init()
    }

    override func createBinders(from value: IssueAssigneeViewModel) -> [ListBinder] {
        return [
            binder(
                value,
                cellType: ListCellType.class(PeopleCell.self),
                size: {
                    return CGSize(
                        width: $0.collection.containerSize.width,
                        height: Styles.Sizes.tableCellHeightLarge
                    )
            },
                configure: { [weak self] in
                    $0.configure(
                        avatarURL: $1.value.avatarURL,
                        username: $1.value.login,
                        showCheckmark: self?.selected == true
                    )
                },
                didSelect: { [weak self] context in
                    guard let strongSelf = self else { return }
                    strongSelf.selected = !strongSelf.selected
                    context.deselect()
                    context.cell?.setCellState(selected: strongSelf.selected)
                    strongSelf.delegate?.didSelect(controller: strongSelf)
            })
        ]
    }

}
