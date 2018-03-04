//
//  MergeHelper.swift
//  FreetimeTests
//
//  Created by Bas Broek on 03/03/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

enum MergeHelper {
    static func combinedMergeStatus(for states: [StatusState]) -> (state: IssueMergeSummaryModel.State, description: String) {
        assert(!states.isEmpty, "Should only check merge status when there is at least one state")
        let state: IssueMergeSummaryModel.State
        let stateDescription: String
        let failureDescription = NSLocalizedString("Some checks failed", comment: "")
        switch states {
        case let states where states.contains(.failure) || states.contains(.error):
            state = .failure
            stateDescription = failureDescription
        case let states where states.contains(.pending):
            state = .pending
            stateDescription = NSLocalizedString("Merge status pending", comment: "")
        case let states where states.containsOnly(.success):
            state = .success
            stateDescription = NSLocalizedString("All checks passed", comment: "")
        default:
            assert(false, "This should only occur when any of the `states` are of type `.expected`, which we have no clue of when it is used. The documentation (https://developer.github.com/v4/enum/statusstate/) doesn't answer that question either.")
            state = .failure
            stateDescription = failureDescription
        }

        return (state, stateDescription)
    }
}
