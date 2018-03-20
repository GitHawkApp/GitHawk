//
//  PeopleSectionController.swift
//  Freetime
//
//  Created by Steven Deutsch on 2/13/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import IGListKit

protocol PeopleSectionControllerDelegate: class {
    func shouldUpdateCellForUser(login: String) -> Bool
}

final class PeopleSectionController: ListGenericSectionController<IssueAssigneeViewModel> {

    weak var delegate: PeopleSectionControllerDelegate?
    var isSelected: Bool

    init(isSelected: Bool, delegate: PeopleSectionControllerDelegate) {
        self.isSelected = isSelected
        self.delegate = delegate
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { fatalError("Collection context must be set") }
        return CGSize(width: context.containerSize.width, height: Styles.Sizes.tableCellHeightLarge)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let object = self.object else { fatalError("Missing object") }
        guard let cell = collectionContext?.dequeueReusableCell(of: PeopleCell.self, for: self, at: index) as? PeopleCell else {
            fatalError("Missing context or cell is wrong type.")
        }
        cell.configure(avatarURL: object.avatarURL, username: object.login, showCheckmark: isSelected)
        return cell
    }



    override func didSelectItem(at index: Int) {
        guard let object = self.object else { fatalError("Missing object") }
        guard let cell = collectionContext?.cellForItem(at: index, sectionController: self) as? PeopleCell else {
            fatalError("Cell is not a PeopleCell")
        }
        guard let shouldUpdate = delegate?.shouldUpdateCellForUser(login: object.login), shouldUpdate else { return }
        isSelected = !isSelected
        cell.setCellState(selected: isSelected)
    }
}
