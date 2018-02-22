//
//  LabelDetails.swift
//  Freetime
//
//  Created by Sherlock, James on 26/11/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class LabelRepoDetails {
    
    let owner: String
    let repo: String
    let label: String
    
    init(owner: String, repo: String, label: String) {
        self.owner = owner
        self.repo = repo
        self.label = label
    }
    
}
