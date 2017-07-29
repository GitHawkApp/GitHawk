//
//  SegmentedControlModel+Repository.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension SegmentedControlModel {
    
    static func forRepository() -> SegmentedControlModel {
        return SegmentedControlModel(items: ["Issues", "Pull Requests"])
    }
    
    var issuesSelected: Bool {
        return items[selectedIndex] == "Issues"
    }
    
}
