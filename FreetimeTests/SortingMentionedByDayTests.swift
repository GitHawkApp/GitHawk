//
//  SortingMentionedByDayTests.swift
//  FreetimeTests
//
//  Created by Alexey Karataev on 09.03.2019.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime
@testable import StyledTextKit
@testable import GitHubAPI

class SortingMentionedByDayTests: XCTestCase {
    func testSortingMentionedByDay() {
        // MARK: - given
        let models = 5
        let parsed = InboxDashboardModelBuilder.provide(number: models)
        let mentioned = V3IssuesRequest.FilterType.mentioned
        let created = V3IssuesRequest.FilterType.created
        let assigned = V3IssuesRequest.FilterType.assigned
        // MARK: - when
        let mentionedSorted = parsed.sortedMentionedByDate(filter: mentioned)
        let createdSorted = parsed.sortedMentionedByDate(filter: created)
        let assignedSorted = parsed.sortedMentionedByDate(filter: assigned)
        // MARK: - then
        XCTAssert(zip(mentionedSorted,
            parsed.sorted(by: {$0.date > $1.date}))
            .allSatisfy { $0.date == $1.date }, "Mentioned is not sorted by day")
        XCTAssert(zip(createdSorted, parsed)
            .allSatisfy { $0.date == $1.date }, "Sorting affect created feed")
        XCTAssert(zip(assignedSorted, parsed)
            .allSatisfy { $0.date == $1.date }, "Sorting affect assigned feed")
    }
}

class InboxDashboardModelBuilder {
    let model: InboxDashboardModel
    private init(date: Date) {
        self.model = InboxDashboardModel(owner: "", name: "", number: 0, date: date,
            text: StyledTextRenderer(string: StyledTextString(styledTexts: []),
            contentSizeCategory: UIContentSizeCategory(rawValue: "")),
            isPullRequest: false, state: .open
        )
    }
    static func provide(number: Int, with interval: TimeInterval = TimeInterval(86400)) -> [InboxDashboardModel] {
        return (1...number).map { InboxDashboardModelBuilder(date: Date() + interval * Double($0)).model }
    }
}
