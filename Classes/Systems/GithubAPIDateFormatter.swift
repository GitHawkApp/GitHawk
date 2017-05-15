//
//  GithubAPIDateFormatter.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

private let dateFormatter = DateFormatter()
func GithubAPIDateFormatter() -> DateFormatter {
    // https://developer.github.com/v3/#schema
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormatter
}
