//
//  SearchViewController.swift
//  FreetimeTests
//
//  Created by Hesham Salman on 10/29/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import XCTest
import IGListKit

@testable import Freetime

class SearchViewControllerTests: XCTestCase {

    typealias State = SearchViewController.State

    var viewController: SearchViewController!
    var githubClient: GithubClient!
    var mockClient: MockClient!
    var mockStore: MockSearchRecentStore!

    override func setUp() {
        super.setUp()
        mockStore = MockSearchRecentStore()
        mockClient = MockClient()
        githubClient = GithubClient(mockClient: mockClient)
        viewController = SearchViewController(client: githubClient, store: mockStore)

        viewController.loadViewIfNeeded()
    }

    func test_search_updatesState() {
        viewController.search(term: "Lord Shaxx")
        guard case .loading = viewController.state else { return XCTFail("Unexpected state of type: \(viewController.state)") }
    }

    func test_objectsForListAdapter_loadingState() {
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: nil)
        viewController.state = .loading(MockCancellable(), SearchQuery.search("Lord Saladin"))
        XCTAssertTrue(viewController.objects(for: adapter).isEmpty)
    }

    func test_objectsForListAdapter_resultsState() {
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: nil)

        let expected: [ListDiffable] = [
            "Twilight Gap" as ListDiffable,
            "Exodus Blue" as ListDiffable,
            "Firebase Delphi"  as ListDiffable
        ]
        viewController.state = .results(expected)

        let actual = viewController.objects(for: adapter) as? [String]
        XCTAssertEqual(expected as? [String], actual)
    }

    func test_objectsForListAdapter_resultsState_emptyResults() {
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: nil)

        let expected: [ListDiffable] = [
            "com.freetime.SearchViewController.no-results-key" as ListDiffable
        ]
        viewController.state = .results([])

        let actual = viewController.objects(for: adapter) as? [String]
        XCTAssertEqual(expected as? [String], actual)
    }

    func test_objectsForListAdapter_idleState_emptyResults() {
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: nil)
        mockStore.mockValues = []
        viewController.state = .idle

        let expected: [ListDiffable] = []

        let actual = viewController.objects(for: adapter) as? [String]
        XCTAssertEqual(expected as? [String], actual)
    }

    func test_objectsForListAdapter_idleState_recentSearches() {
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: nil)
        let mockValues = [
            SearchQuery.search("Blind Watch"),
            SearchQuery.search("Bastion"),
            SearchQuery.search("Rusted Lands")
        ]
        mockStore.mockValues = mockValues
        viewController.state = .idle

        let expected: [ListDiffable] = ["com.freetime.SearchViewController.recent-header-key" as ListDiffable] +  mockValues.compactMap(SearchRecentViewModel.init(query:))
        let actual = viewController.objects(for: adapter)

        zip(expected, actual).enumerated().forEach { index, pair in
            switch index {
            case 0:
                guard let expected = pair.0 as? String,
                    let actual = pair.1 as? String
                    else { return XCTFail("Unexpected data types at index \(index)") }
                XCTAssertEqual(expected, actual)
            default:
                guard let expected = pair.0 as? SearchRecentViewModel,
                    let actual = pair.1 as? SearchRecentViewModel
                    else { return XCTFail("Unexpected data types at index \(index)") }
                XCTAssertEqual(expected.query, actual.query)
            }
        }
    }

    func test_listAdapter_sectionControllerForObject_noResults() {
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: nil)

        XCTAssertTrue(viewController.listAdapter(adapter, sectionControllerFor: viewController.noResultsKey) is SearchNoResultsSectionController)
    }

    func test_listAdapter_sectionControllerForObject_recent() {
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: nil)

        XCTAssertTrue(viewController.listAdapter(adapter, sectionControllerFor: viewController.recentHeaderKey) is SearchRecentHeaderSectionController)
    }

    func test_listAdapter_sectionControllerForObject_repo() {
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: nil)
        let object = SearchRepoResultFactory.create()

        XCTAssertTrue(viewController.listAdapter(adapter, sectionControllerFor: object) is SearchResultSectionController)
    }

    func test_listAdapter_sectionControllerForObject_searchRecent() {
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: nil)
        let object: ListDiffable = SearchRecentViewModel(query: SearchQuery.search("The Burning Shrine"))

        XCTAssertTrue(viewController.listAdapter(adapter, sectionControllerFor: object) is SearchRecentSectionController)
    }

}
