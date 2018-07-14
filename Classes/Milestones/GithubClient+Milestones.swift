//
//  GithubClient+Milestones.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import Squawk
import GitHubAPI

extension GithubClient {

    func fetchMilestones(
        owner: String,
        repo: String,
        completion: @escaping (Result<[Milestone]>) -> Void
        ) {

        client.send(V3MilestoneRequest(owner: owner, repo: repo)) { result in
            switch result {
            case .success(let response):
                let milestones = response.data.sorted { lhs, rhs in
                    switch (lhs.dueOn, rhs.dueOn) {
                    case (let lhsDue?, let rhsDue?):
                        return lhsDue.compare(rhsDue) == .orderedAscending
                    case (_?, nil):
                        return true
                    case (nil, _?):
                        return false
                    default:
                        return lhs.title < rhs.title
                    }
                }
                completion(.success(milestones.map {
                    Milestone(
                        number: $0.number,
                        title: $0.title,
                        dueOn: $0.dueOn,
                        openIssueCount: $0.openIssues,
                        totalIssueCount: $0.openIssues + $0.closedIssues
                    )
                }))
            case .failure(let error):
                completion(.error(error))
            }
        }
    }

    func setMilestone(
        previous: IssueResult,
        owner: String,
        repo: String,
        number: Int,
        milestone: Milestone?
        ) {
        guard milestone != previous.milestone else { return }

        let eventTitle: String
        let type: IssueMilestoneEventModel.MilestoneType
        if let milestone = milestone {
            type = .milestoned
            eventTitle = milestone.title
        } else {
            // if removing milestone and there was no previous, just return
            guard let previousMilestone = previous.milestone else { return }
            eventTitle = previousMilestone.title
            type = .demilestoned
        }

        let newEvent = IssueMilestoneEventModel(
            id: UUID().uuidString,
            actor: userSession?.username ?? Constants.Strings.unknown,
            milestone: eventTitle,
            date: Date(),
            type: type,
            contentSizeCategory: UIApplication.shared.preferredContentSizeCategory,
            width: 0 // pay perf cost when asked
        )

        let optimisticResult = previous.withMilestone(
            milestone,
            timelinePages: previous.timelinePages(appending: [newEvent])
        )

        let cache = self.cache

        // optimistically update the cache, listeners can react as appropriate
        cache.set(value: optimisticResult)

        client.send(V3SetMilestonesRequest(
            owner: owner,
            repo: repo,
            number: number,
            milestoneNumber: milestone?.number)
        ) { result in
            switch result {
            case .success: break
            case .failure:
                cache.set(value: previous)
                Squawk.showGenericError()
            }
        }
    }

}
