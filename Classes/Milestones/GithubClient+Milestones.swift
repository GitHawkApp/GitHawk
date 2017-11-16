//
//  GithubClient+Milestones.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension GithubClient {

    func fetchMilestones(
        owner: String,
        repo: String,
        completion: @escaping (Result<[Milestone]>) -> Void
        ) {
        request(GithubClient.Request(
            path: "repos/\(owner)/\(repo)/milestones"
        ) { (response, _) in
            if let jsonArr = response.value as? [[String: Any]] {
                var milestones = [Milestone]()
                for json in jsonArr {
                    if let milestone = Milestone(json: json) {
                        milestones.append(milestone)
                    }
                }
                milestones.sort { $0.number < $1.number }
                completion(.success(milestones))
            } else {
                completion(.error(response.error))
            }
        })
    }

    func setMilestone(
        previous: IssueResult,
        owner: String,
        repo: String,
        number: Int,
        milestone: Milestone?
        ) {

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
            type: type
        )

        let optimisticResult = previous.withMilestone(
            milestone,
            timelinePages: previous.timelinePages(appending: [newEvent])
        )

        let cache = self.cache

        // optimistically update the cache, listeners can react as appropriate
        cache.set(value: optimisticResult)

        // https://developer.github.com/v3/issues/#edit-an-issue
        request(Request(
            path: "repos/\(owner)/\(repo)/issues/\(number)",
            method: .patch,
            parameters: [ "milestone": milestone?.number ?? NSNull() ],
            completion: { (response, _) in
                // rewind to a previous object if response isn't a success
                if response.response?.statusCode != 200 {
                    cache.set(value: previous)
                    ToastManager.showGenericError()
                }
        }))
    }

}
