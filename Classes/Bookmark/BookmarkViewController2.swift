//
//  BookmarkViewController2.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/23/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

protocol BookmarkViewControllerClient {
    var sessionToken: String { get }
    var username: String { get }
}

final class BookmarkViewController2: BaseListViewController<String>,
BaseListViewControllerDataSource {

    typealias Client = BookmarkViewControllerClient & BookmarkCloudMigratorClient

    private let client: Client
    private let migrator: BookmarkCloudMigrator

    init(client: Client) {
        self.client = client
        self.migrator = BookmarkCloudMigrator(
            username: client.username,
            oldBookmarks: BookmarkStore(token: client.sessionToken).values,
            client: client
        )

        super.init(
            emptyErrorMessage: NSLocalizedString("Error loading bookmarks", comment: ""),
            backgroundThreshold: 5 * 60
        )

        // start migration on init (app start) so likely finished before opening
        // the bookmark tab
        self.migrator.sync { [weak self] result in
            switch result {
            case .noMigration: break
            case .success: self?.handleMigrationSuccess()
            case .error(let error): self?.handleMigration(error: error)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func handleMigration(error: Error?) {
        // system alert displayed even if the bookmark tab isn't open
        // to warn user that bookmarks aren't going to function
        let alert = UIAlertController(
            title: NSLocalizedString("Bookmarks Error", comment: ""),
            message: NSLocalizedString(
                "There was an error migrating your bookmarks to iCloud. Please open the bookmarks tab and tap \"Migrate\" to try again.",
                comment: ""
            ),
            preferredStyle: .alert
        )
        alert.add(action: UIAlertAction(title: Constants.Strings.ok, style: .default))
        present(alert, animated: trueUnlessReduceMotionEnabled)
    }

    private func handleMigrationSuccess() {
        fetch(page: nil)
    }

    // MARK: Overrides

    override func fetch(page: String?) {
        switch migrator.state {
        case .inProgress, .error: return
        case .success: break
        }

        // TODO fetch nodes from network
    }

    // MARK: BaseListViewControllerDataSource

    func models(adapter: ListSwiftAdapter) -> [ListSwiftPair] {
        switch migrator.state {
            // if migrating return empty so spinner is showen
        case .inProgress: return []
        case .error: return [
            ListSwiftPair.pair("migration-error", { BookmarkMigrationSectionController() })
            ]
        case .success: break
        }

        var models = [ListSwiftPair]()
        /**
         - get all gqlIDs
         - fetch from cache
         - if type is model that we support, add it to the models array
         */
        return models
    }

    // MARK: BaseListViewControllerEmptyDataSource

    // TODO create bookmark SC and return it here
//    func emptyModel(for adapter: ListSwiftAdapter) -> ListSwiftPair {
//        return ListSwiftPair.pair(NSLocalizedString("No changes found.", comment: ""), {
//            EmptyMessageSectionController()
//        })
//    }

}
