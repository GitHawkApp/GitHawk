//
//  DateDetailsFormatter.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 5/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

private let dateFormatter = DateFormatter()
func DateDetailsFormatter() -> DateFormatter {
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .long
    return dateFormatter
}

