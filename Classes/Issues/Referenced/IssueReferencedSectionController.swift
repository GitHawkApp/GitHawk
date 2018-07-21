//
//  IssueReferencedSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueReferencedSectionController: ListGenericSectionController<IssueReferencedModel> {

    private let client: GithubClient

    init(client: GithubClient) {
        self.client = client
        super.init()
        inset = Styles.Sizes.issueInset(vertical: 0)
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize(for: self).width,
            let object = self.object
            else { fatalError("Missing context") }
        return CGSize(
            width: width,
            height: object.string.viewSize(in: width).height
        )
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueReferencedCell.self, for: self, at: index) as? IssueReferencedCell,
        let object = self.object
            else { fatalError("Missing context, model, or cell wrong type") }
        cell.configure(object)
        cell.delegate = viewController
        return cell
    }

    override func didSelectItem(at index: Int) {
        guard let object = self.object else { return }
        let model = IssueDetailsModel(owner: object.owner, repo: object.repo, number: object.number)
        let controller = IssuesViewController(
            client: client,
            model: model
        )
        viewController?.show(controller, sender: nil)
    }

}
