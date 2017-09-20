//
//  ColumnCardSectionController.swift
//  Freetime
//
//  Created by Sherlock, James on 20/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

final class ColumnCardSectionController: ListGenericSectionController<Project.Details.Column.Card> {
    
    let client: GithubClient
    let repo: RepositoryDetails
    
    init(client: GithubClient, repo: RepositoryDetails) {
        self.client = client
        self.repo = repo
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        let titleHeight = object?.title.textViewSize(width).height ?? 0
        let descriptionHeight = object?.description.textViewSize(width).height ?? 0
        return CGSize(width: width, height: ceil(titleHeight + descriptionHeight))
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: ColumnCardCell.self, for: self, at: index) as? ColumnCardCell,
            let object = self.object else {
                fatalError("Missing context, object, or cell is wrong type")
        }
        
        cell.configure(object)
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        guard let object = self.object else { return }
        collectionContext?.deselectItem(at: index, sectionController: self, animated: true)
        
        switch object.type {
        case .note: return // Notes don't do anything
        case .issue(_, let number), .pullRequest(_, let number):
            let issueModel = IssueDetailsModel(owner: repo.owner, repo: repo.name, number: number)
            let controller = IssuesViewController(client: client, model: issueModel)
            viewController?.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}
