//
//  ProfileResult.swift
//  Freetime
//
//  Created by Sash Zats on 2/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import FlatCache

struct ProfileResult: Cachable {
  let id: String
  let login: String
  let name: String?
  let bio: String?
  let avatarUrl: URL?
  let location: String?
}
