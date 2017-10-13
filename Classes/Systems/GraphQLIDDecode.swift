//
//  GraphQLIDDecode.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 9/27/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func GraphQLIDDecode(id: String, separator: String) -> Int? {
    guard let data = Data(base64Encoded: id, options: [.ignoreUnknownCharacters]),
    let text = String(data: data, encoding: .utf8)
        else { return nil }
    return (text.components(separatedBy: separator).last as NSString?)?.integerValue
}
