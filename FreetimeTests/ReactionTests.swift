//
//  ReactionTests.swift
//  FreetimeTests
//
//  Created by Bas Broek on 14/10/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime

private let viewer = "rnystrom"

class ReactionTests: XCTestCase {

    private static func createReactionViewModel(users _users: [String]) -> ReactionViewModel {
        let count = _users.count
        let users: [String] // the logic below mimicks the users.count capping at 3: https://github.com/rnystrom/GitHawk/issues/541#issuecomment-336378078
        if _users.count > 3 {
            users = Array(_users.prefix(3))
        } else {
            users = _users
        }

        let viewerDidReact = users.contains(viewer)
        return ReactionViewModel(content: .thumbsUp, count: count, viewerDidReact: viewerDidReact, users: users)
    }

    let singleOther = createReactionViewModel(users: ["basthomas"])
    let singleSelf = createReactionViewModel(users: [viewer])

    let doubleOther = createReactionViewModel(users: ["basthomas", "sherlouk"])
    let doubleSelf = createReactionViewModel(users: [viewer, "sherlouk"])

    let tripleOther = createReactionViewModel(users: ["basthomas", "sherlouk", "weyert"])
    let tripleSelf = createReactionViewModel(users: [viewer, "sherlouk", "weyert"])

    let multiOther = createReactionViewModel(users: ["basthomas", "sherlouk", "weyert", "rizwankce"])
    let multiSelf = createReactionViewModel(users: [viewer, "sherlouk", "weyert", "rizwankce"])
    let multiSelfOutOfRange = createReactionViewModel(users: ["sherlouk", "weyert", "rizwankce", viewer])

    let singleFormat = NSLocalizedString("%@", comment: "")
    let doubleFormat = NSLocalizedString("%@ and %@", comment: "")
    let tripleFormat = NSLocalizedString("%@, %@ and %@", comment: "")

//    let difference = model.count - users.count
    let multiFormat = NSLocalizedString("%@, %@, %@ and %d other(s)", comment: "")
//    return .localizedStringWithFormat(format, users[0], users[1], users[2], difference)

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_detailText() {
        XCTAssertEqual(
            createReactionDetailText(model: singleOther),
            .localizedStringWithFormat(singleFormat, singleOther.users[0]))
        XCTAssertEqual(
            createReactionDetailText(model: singleSelf),
            .localizedStringWithFormat(singleFormat, singleSelf.users[0]))

        XCTAssertEqual(
            createReactionDetailText(model: doubleOther),
            .localizedStringWithFormat(doubleFormat, doubleOther.users[0], doubleOther.users[1]))
        XCTAssertEqual(
            createReactionDetailText(model: doubleSelf),
            .localizedStringWithFormat(doubleFormat, doubleSelf.users[0], doubleSelf.users[1]))

        XCTAssertEqual(
            createReactionDetailText(model: tripleOther),
            .localizedStringWithFormat(tripleFormat, tripleOther.users[0], tripleOther.users[1], tripleOther.users[2]))
        XCTAssertEqual(
            createReactionDetailText(model: tripleSelf),
            .localizedStringWithFormat(tripleFormat, tripleSelf.users[0], tripleSelf.users[1], tripleSelf.users[2]))

        XCTAssertEqual(
            createReactionDetailText(model: multiOther),
            .localizedStringWithFormat(multiFormat, multiOther.users[0], multiOther.users[1], multiOther.users[2], multiSelf.count - multiSelf.users.count))
        XCTAssertEqual(
            createReactionDetailText(model: multiSelf),
            .localizedStringWithFormat(multiFormat, multiSelf.users[0], multiSelf.users[1], multiSelf.users[2], multiSelf.count - multiSelf.users.count))
    }

    func test_userCountCapsAtThree() {
        XCTAssertEqual(singleOther.users.count, 1)
        XCTAssertEqual(singleOther.count, 1)

        XCTAssertEqual(singleSelf.users.count, 1)
        XCTAssertEqual(singleSelf.count, 1)

        XCTAssertEqual(doubleOther.users.count, 2)
        XCTAssertEqual(doubleOther.count, 2)

        XCTAssertEqual(doubleSelf.users.count, 2)
        XCTAssertEqual(doubleSelf.count, 2)

        XCTAssertEqual(tripleOther.users.count, 3)
        XCTAssertEqual(tripleOther.count, 3)

        XCTAssertEqual(tripleSelf.users.count, 3)
        XCTAssertEqual(tripleSelf.count, 3)

        XCTAssertEqual(multiOther.users.count, 3)
        XCTAssertEqual(multiOther.count, 4)

        XCTAssertEqual(multiSelf.users.count, 3)
        XCTAssertEqual(multiSelf.count, 4)
    }

    func test_labelContainsViewer() {
        XCTAssertFalse(createReactionDetailText(model: singleOther).contains(viewer))
        XCTAssertTrue(createReactionDetailText(model: singleSelf).contains(viewer))

        XCTAssertFalse(createReactionDetailText(model: doubleOther).contains(viewer))
        XCTAssertTrue(createReactionDetailText(model: doubleSelf).contains(viewer))

        XCTAssertFalse(createReactionDetailText(model: tripleOther).contains(viewer))
        XCTAssertTrue(createReactionDetailText(model: tripleSelf).contains(viewer))

        XCTAssertFalse(createReactionDetailText(model: multiOther).contains(viewer))
        XCTAssertTrue(createReactionDetailText(model: multiSelf).contains(viewer))

        XCTAssertFalse(createReactionDetailText(model: multiSelfOutOfRange).contains(viewer))
    }

    func test_whenModelCountAndUserCountMismatch() {
        let model = ReactionViewModel(content: .thumbsUp, count: 1, viewerDidReact: false, users: [])
        XCTAssertEqual(createReactionDetailText(model: model), "")
    }
}
