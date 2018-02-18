//
//  String+GithubDate.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension String {

    var githubDate: Date? {
        return GithubAPIDateFormatter().date(from: self)
    }

}
