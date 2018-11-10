//
//  SearchResultSectionController.swift
//  Freetime
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

protocol SearchResultSectionControllerDelegate: class {
    func didSelect(sectionController: SearchResultSectionController, repo: RepositoryDetails)
}

final class SearchResultSectionController: ListGenericSectionController<SearchRepoResult> {

    private weak var delegate: SearchResultSectionControllerDelegate?
    private let client: GithubClient

    init(client: GithubClient, delegate: SearchResultSectionControllerDelegate) {
        self.client = client
        self.delegate = delegate
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return collectionContext.cellSize(
            with: Styles.Sizes.tableCellHeight + Styles.Sizes.rowSpacing * 2
        )
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: SearchRepoResultCell.self, for: self, at: index) as? SearchRepoResultCell,
              let object = object else {
            fatalError("Missing context, object, or cell is wrong type")
        }

        cell.configure(result: object)
        return cell
    }

    override func didSelectItem(at index: Int) {
        guard let object = object else { return }

        let repo = RepositoryDetails(
            owner: object.owner,
            name: object.name,
            defaultBranch: object.defaultBranch,
            hasIssuesEnabled: object.hasIssuesEnabled
        )

        delegate?.didSelect(sectionController: self, repo: repo)

        let repoViewController = RepositoryViewController(client: client, repo: repo)
        let navigation = UINavigationController(rootViewController: repoViewController)
        viewController?.showDetailViewController(navigation, sender: nil)
    }

}
