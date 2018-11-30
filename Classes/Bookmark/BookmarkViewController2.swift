//
//  BookmarkViewController2.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/23/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import Squawk

protocol BookmarkViewControllerClient {
    func fetch(graphQLIDs: [String], completion: @escaping (Result<[BookmarkModelType]>) -> Void)
}

enum BookmarkModelType {
    case issue(BookmarkIssueViewModel)
    case repo(RepositoryDetails)
}

final class BookmarkViewController2: BaseListViewController<String>,
BaseListViewControllerDataSource,
BaseListViewControllerEmptyDataSource,
BookmarkIDCloudStoreListener {

    typealias Client = BookmarkViewControllerClient & BookmarkCloudMigratorClient

    private let client: Client
    private let cloudStore: BookmarkIDCloudStore
    private let migrator: BookmarkCloudMigrator
    private var models = [BookmarkModelType]()

    init(
        client: Client,
        cloudStore: BookmarkIDCloudStore,
        oldBookmarks: [Bookmark]
        ) {
        self.client = client
        self.cloudStore = cloudStore
        self.migrator = BookmarkCloudMigrator(
            username: cloudStore.username,
            oldBookmarks: oldBookmarks,
            client: client
        )

        super.init(
            emptyErrorMessage: NSLocalizedString("Error loading bookmarks", comment: ""),
            backgroundThreshold: 5 * 60
        )

        dataSource = self
        emptyDataSource = self

        cloudStore.add(listener: self)

        // start migration on init (app start) so likely finished before opening
        // the bookmark tab
        self.migrator.sync { [weak self] result in
            switch result {
            case .noMigration: break
            case .success(let ids):
                self?.handleMigrationSuccess(graphQLIDs: ids)
            case .error(let error):
                self?.handleMigration(error: error)
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
        update()
    }

    private func handleMigrationSuccess(graphQLIDs: [String]) {
        cloudStore.add(graphQLIDs: graphQLIDs)
        fetch(page: nil)
    }

    // MARK: Overrides

    override func fetch(page: String?) {
        switch migrator.state {
        case .inProgress, .error: return
        case .success: break
        }

        client.fetch(graphQLIDs: cloudStore.ids) { [weak self] result in
            switch result {
            case .success(let models):
                self?.models = models
                self?.update()
            case .error(let error):
                self?.error()
                Squawk.show(error: error)
            }
        }
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

        return models.map {
            switch $0 {
            case .issue(let model):
                return ListSwiftPair.pair(model, {
                    BookmarkIssueSectionController()
                })
            case .repo(let model):
                return ListSwiftPair.pair(model, {
                    BookmarkRepoSectionController()
                })
            }
        }
    }

    // MARK: BaseListViewControllerEmptyDataSource

    func emptyModel(for adapter: ListSwiftAdapter) -> ListSwiftPair {
        let model = InitialEmptyViewModel(
            imageName: "bookmarks-large",
            title: NSLocalizedString("Add Bookmarks", comment: ""),
            description: NSLocalizedString("Bookmark your favorite issues,\npull requests, and repositories.", comment: "")
        )
        return ListSwiftPair.pair(model, { InitialEmptyViewSectionController() })
    }

    // MARK: BookmarkIDCloudStoreListener

    func didUpdateBookmarks(in store: BookmarkIDCloudStore) {
        fetch(page: nil)
    }

}
