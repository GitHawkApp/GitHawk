//
//  NotificationNextPageSectionController.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 7/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol NotificationNextPageSectionControllerDelegate: class {
    func didSelect(notificationSectionController: NotificationNextPageSectionController)
}

final class NotificationNextPageSectionController: ListGenericSectionController<NSNumber> {

    weak var delegate: NotificationNextPageSectionControllerDelegate? = nil

    init(delegate: NotificationNextPageSectionControllerDelegate) {
        self.delegate = delegate
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        return CGSize(width: width, height: Styles.Sizes.tableCellHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(
            of: NotificationNextPageCell.self,
            for: self,
            at: index
            ) as? NotificationNextPageCell,
            let object = self.object
            else { fatalError("Missing context, object, or cell is wrong type") }
        // add one so reads as loading the NEXT page
        cell.configure(page: object.intValue)
        return cell
    }

    override func didSelectItem(at index: Int) {
        delegate?.didSelect(notificationSectionController: self)
    }

}
