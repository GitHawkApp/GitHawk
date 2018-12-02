//
//  InboxFilterReposViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/2/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class InboxFilterReposViewController: BaseListViewController<String>,
BaseListViewControllerDataSource {

    private let inboxFilterController: InboxFilterController
    private var repos = [RepositoryDetails]()

    init(inboxFilterController: InboxFilterController) {
        self.inboxFilterController = inboxFilterController
        super.init(emptyErrorMessage: NSLocalizedString("Error loading repos", comment: ""))
        title = Constants.Strings.watchedRepos
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func fetch(page: String?) {
        // TODO
    }

    // MARK: BaseListViewControllerDataSource

    func models(adapter: ListSwiftAdapter) -> [ListSwiftPair] {
        return repos.map { [inboxFilterController] model in
            ListSwiftPair.pair(model, {
                InboxFilterRepoSectionController(inboxFilterController: inboxFilterController)
            })
        }
    }

}
