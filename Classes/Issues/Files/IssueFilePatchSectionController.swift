//
//  IssueFilePatchSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueFilePatchSectionController: ListGenericSectionController<File> {

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width
            else { fatalError("Missing context") }
        return CGSize(width: width, height: Styles.Sizes.tableCellHeightLarge)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueFileCell.self, for: self, at: index),
            let object = self.object
            else { fatalError("Missing context or object") }
        return cell
    }

    override func didSelectItem(at index: Int) {
        // push file vc
    }

}
