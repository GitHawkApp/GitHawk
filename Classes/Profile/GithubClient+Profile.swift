//
//  GithubClient+Profile.swift
//  Freetime
//
//  Created by Sash Zats on 2/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

extension GithubClient {
  func fetchProfile(completion: @escaping (Result<ProfileResult>) -> Void) {
    let query = FetchProfileQuery()
    let cache = self.cache
    fetch(query: query) { (result, error) in
      guard let viewer = result?.data?.viewer else {
        completion(.error(nil))
        return
      }

      let result = ProfileResult(
        id: viewer.id,
        login: viewer.login,
        name: viewer.name,
        bio: viewer.bio,
        avatarUrl: URL(string: viewer.avatarUrl),
        location: viewer.location
      )
      DispatchQueue.main.async {
        cache.set(value: result)
        completion(.success(result))
      }

    }
  }
}
