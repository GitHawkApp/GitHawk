//
//  IssueDetailsModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/11/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

struct IssueDetailsModel {

    let owner: String
    let repo: String
    let number: Int

}

extension IssueDetailsModel {
    init?(url: URL) {
        let components: [String] = url.pathComponents.filter { $0 != "/" } // removing the /
        guard components.count == 4,
            components[2].contains("issue") || components[2].contains("pull"),
            let id = Int(components[3]) else {
                return nil
        }
        owner = components[0]
        repo = components[1]
        number = id
    }
}
