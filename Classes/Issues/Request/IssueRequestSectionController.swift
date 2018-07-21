//
//  IssueRequestSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssueRequestSectionController: ListGenericSectionController<IssueRequestModel> {

    override init() {
        super.init()
        inset = Styles.Sizes.issueInset(vertical: 0)
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.adjustedContainerSize(for: self).width,
        let object = self.object
        else { fatalError("Collection context must be set") }
        return CGSize(
            width: width,
            height: object.string.viewSize(in: width).height
        )
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueRequestCell.self, for: self, at: index) as? IssueRequestCell,
            let object = self.object
            else { fatalError("Missing collection context, cell incorrect type, or object missing") }
        cell.configure(object)
        cell.delegate = viewController
        return cell
    }

}
