//
//  ProjectSummarySectionController.swift
//  Freetime
//
//  Created by Sherlock, James on 19/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

final class ProjectSummarySectionController: ListGenericSectionController<Project> {
    
    private let client: GithubClient
    private let repo: RepositoryDetails
    
    init(client: GithubClient, repo: RepositoryDetails) {
        self.client = client
        self.repo = repo
        super.init()
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        return CGSize(width: width, height: 100)
//        return CGSize(width: width, height: ceil(object?.title.textViewSize(width).height ?? 0))
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: ProjectSummaryCell.self, for: self, at: index) as? ProjectSummaryCell,
            let object = self.object else {
                fatalError("Missing context, object, or cell is wrong type")
        }
        
        cell.configure(object)
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        guard let project = object else { return }
        let controller = ProjectViewController(client: client, repository: repo, project: project)
        let navController = UINavigationController(rootViewController: controller)
        viewController?.showDetailViewController(navController, sender: nil)
    }
    
}
