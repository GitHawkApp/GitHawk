//
//  GitHubClient+UserProfileModel.swift
//  Freetime
//
//  Created by B_Litwin on 8/12/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import Apollo

extension GithubClient {
    
    enum UserProfileResultType {
        case error(Error?)
        case success(UserProfileModel)
    }
    
    func fetchUserProfile<T>(query: T,
                             completion: @escaping (UserProfileResultType) -> Void
        ) where T: UserQuery {
        client.query(query, result: { $0 }) { result in
            switch result {
            case .failure(let error):
                completion(.error(error))
            case .success(let data):
                guard let user = data.user else {
                    //TODO
                    completion(.error(nil))
                    return 
                }
                
                completion( .success(UserProfileModel(user: user)) )
            }
        }
    }
}
