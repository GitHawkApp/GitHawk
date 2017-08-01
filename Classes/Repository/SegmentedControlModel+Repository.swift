//
//  SegmentedControlModel+Repository.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension SegmentedControlModel {
    
    static func forRepository(_ repo: RepositoryLoadable) -> SegmentedControlModel {
        var items = [NSLocalizedString("Pull Requests", comment: "")]
        
        if repo.hasIssuesEnabled {
            items.insert(NSLocalizedString("Issues", comment: ""), at: 0)
        }
        
        return SegmentedControlModel(items: items)
    }
    
    var issuesSelected: Bool {
        return items[selectedIndex] == NSLocalizedString("Issues", comment: "")
    }
    
}
