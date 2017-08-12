//
//  IssueViewFilesSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/11/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueViewFilesSectionController: ListSectionController {

    private let issueModel: IssueDetailsModel
    private let client: GithubClient

    init(issueModel: IssueDetailsModel, client: GithubClient) {
        self.issueModel = issueModel
        self.client = client
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Collection context must be set") }
        return CGSize(width: width, height: Styles.Sizes.labelEventHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueViewFilesCell.self, for: self, at: index)
            else { fatalError("Missing collection context") }
        return cell
    }

    override func didSelectItem(at index: Int) {
        collectionContext?.deselectItem(at: index, sectionController: self, animated: true)

        guard let controller = UIStoryboard(name: "Files", bundle: Bundle.main)
            .instantiateInitialViewController() as? IssueFilesViewController
            else { return }
        controller.configure(model: issueModel, client: client)
        viewController?.showDetailViewController(controller, sender: nil)
    }

}
