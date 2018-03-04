//
//  V3Release.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3Release: Codable {

    public let tagName: String

    enum CodingKeys: String, CodingKey {
        case tagName = "tag_name"
    }

}
