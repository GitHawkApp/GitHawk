//
//  IssueLabeledSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueLabeledSectionController: ListGenericSectionController<IssueLabeledModel> {

    private let issueModel: IssueDetailsModel
    
    init(issueModel: IssueDetailsModel) {
        self.issueModel = issueModel
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Collection context must be set") }
        return CGSize(width: width, height: object?.attributedString.textViewSize(width).height ?? 0)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueLabeledCell.self, for: self, at: index) as? IssueLabeledCell,
            let object = self.object
            else { fatalError("Missing collection context, cell incorrect type, or object missing") }
        cell.configure(object)
        cell.delegate = viewController
        return cell
    }

}
