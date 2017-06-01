//
//  IssueCollapsedBodies.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/1/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

func IssueCollapsedBodies(bodies: [AnyObject]) -> (AnyObject, CGFloat)? {
    let cap: CGFloat = 300
    // minimum height to collapse so expanding shows significant amount of content
    let minDelta = CollapseCellMinHeight * 3

    var totalHeight: CGFloat = 0
    for body in bodies {
        let height = bodyHeight(viewModel: body)
        totalHeight += height
        if totalHeight > cap, totalHeight - cap > minDelta {
            let collapsedBodyHeight = max(cap - (totalHeight - height), CollapseCellMinHeight)
            return (body, collapsedBodyHeight)
        }
    }
    return nil
}
