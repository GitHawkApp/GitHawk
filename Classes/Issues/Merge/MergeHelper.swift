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
        var hasError = false, hasPending = false
        for state in states {
            switch state {
            case .error, .failure, .expected, .__unknown: hasError = true
            case .pending: hasPending = true
            case .success: break
            }
        }

        if hasError {
            return (.failure, NSLocalizedString("Some checks failed", comment: ""))
        } else if hasPending {
            return (.pending, NSLocalizedString("Merge status pending", comment: ""))
        } else {
            return (.success, NSLocalizedString("All checks passed", comment: ""))
        }
    }
}
