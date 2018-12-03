//
//  GithubClient+InboxFilterController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/2/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubAPI

extension GithubClient: InboxFilterControllerClient {

    func fetchSubscriptions(completion: @escaping (Result<[RepositoryDetails]>) -> Void) {
        guard let username = userSession?.username else {
            completion(.error(nil))
            return
        }
        client.send(V3SubscriptionsRequest(username: username)) { result in
            switch result {
            case .failure(let error):
                completion(.error(error))
            case .success(let data):
                let repos = data.data.map {
                    RepositoryDetails(owner: $0.owner.login, name: $0.name)
                }
                completion(.success(repos))
            }
        }
    }
    
}
