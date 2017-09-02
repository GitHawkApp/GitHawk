//
//  SearchResultSectionController.swift
//  Freetime
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

final class SearchResultSectionController: ListGenericSectionController<SearchRepoResult> {

    private let client: GithubClient
    
    init(client: GithubClient) {
        self.client = client
        super.init()
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        return CGSize(width: width, height: Styles.Sizes.tableCellHeight + Styles.Sizes.rowSpacing * 2)
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
        let repoViewController = RepositoryViewController(client: client, repo: object)
        viewController?.navigationController?.pushViewController(repoViewController, animated: true)
    }
    
}
