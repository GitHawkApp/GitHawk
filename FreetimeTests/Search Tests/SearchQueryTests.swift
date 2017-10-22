//
//  SearchQueryTests.swift
//  FreetimeTests
//
//  Created by Hesham Salman on 10/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import XCTest

@testable import Freetime
class SearchQueryTests: XCTestCase {

    var encoder: JSONEncoder!
    var decoder: JSONDecoder!

    override func setUp() {
        super.setUp()
        encoder = JSONEncoder()
        decoder = JSONDecoder()
    }

    func test_encodesAndDecodes_search() {
        let query = SearchQuery.search("MindHunter")
        let data = try? encoder.encode(query)

        let expected = query
        let actual = try? decoder.decode(SearchQuery.self, from: data ?? Data())

        XCTAssertEqual(expected, actual)
    }

    func test_encodesAndDecodes_recentlyViewed() {
        let recentlyViewed = RepositoryDetails(owner: "Instagram", name: "IGListKit", hasIssuesEnabled: true)
        let query = SearchQuery.recentlyViewed(recentlyViewed)
        let data = try? encoder.encode(query)

        let expected = query
        let actual = try? decoder.decode(SearchQuery.self, from: data ?? Data())

        XCTAssertEqual(expected, actual)
    }

    func test_equality() {
        let chickenWings = SearchQuery.search("Bonchon")
        let dimSum = SearchQuery.search("Nom Wah")

        let koreanBBQDetails = RepositoryDetails(owner: "678 Corp", name: "Kang Ho Dong Baekjeong", hasIssuesEnabled: false)
        let hotPotDetails = RepositoryDetails(owner: "Favor Taste", name: "99", hasIssuesEnabled: false)
        let koreanBBQ = SearchQuery.recentlyViewed(koreanBBQDetails)
        let hotPot = SearchQuery.recentlyViewed(hotPotDetails)

        XCTAssertNotEqual(koreanBBQ, hotPot)
        XCTAssertNotEqual(koreanBBQ, dimSum)
        XCTAssertNotEqual(chickenWings, dimSum)
        XCTAssertNotEqual(chickenWings, hotPot)

        let newKoreanBBQLocation = SearchQuery.recentlyViewed(koreanBBQDetails)
        XCTAssertEqual(koreanBBQ, newKoreanBBQLocation)

        let newChickenWingLocation = SearchQuery.search("Bonchon")
        XCTAssertEqual(chickenWings, newChickenWingLocation)
    }

}
