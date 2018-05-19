//
//  MergeTests.swift
//  FreetimeTests
//
//  Created by Bas Broek on 03/03/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime

class MergeTests: XCTestCase {

    func test_mergeStatuses_containsOnlyError() {
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.error, .error, .error]).state,
            .failure)
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.error]).state,
            .failure)
    }

    func test_mergeStatuses_containsError() {
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.error, .failure]).state,
            .failure)
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.error, .pending]).state,
            .failure)
    }

    func test_mergeStatuses_containsOnlyFailure() {
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.failure, .failure, .failure]).state,
            .failure)
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.failure]).state,
            .failure)
    }

    func test_mergeStatuses_containsFailure() {
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.failure, .success]).state,
            .failure)
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.failure, .pending]).state,
            .failure)
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.pending, .failure]).state,
            .failure)
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.failure, .pending, .success]).state,
            .failure)
    }

    func test_mergeStatuses_containsFailure_andError() {
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.error, .failure]).state,
            .failure)
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.failure, .error]).state,
            .failure)
    }

    func test_mergeStatuses_containsPending_butNoErrorOrFailure() {
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.pending, .pending, .pending]).state,
            .pending)
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.pending, .success]).state,
            .pending)
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.success, .pending]).state,
            .pending)
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.success, .pending, .success]).state,
            .pending)
    }

    func test_mergeStatuses_containsOnlySuccess() {
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.success, .success]).state,
            .success)
        XCTAssertEqual(
            MergeHelper.combinedMergeStatus(for: [.success]).state,
            .success)
    }
}
