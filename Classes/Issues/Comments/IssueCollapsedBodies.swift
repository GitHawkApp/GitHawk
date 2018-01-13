//
//  IssueCollapsedBodies.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/1/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

private func bodyIsCollapsible(body: Any) -> Bool {
    if body is IssueCommentHrModel,
        body is IssueCommentHtmlModel {
        return false
    } else {
        return true
    }
}

func IssueCollapsedBodies(bodies: [AnyObject], width: CGFloat) -> (AnyObject, CGFloat)? {
    let cap: CGFloat = 300
    // minimum height to collapse so expanding shows significant amount of content
    let minDelta = IssueCommentBaseCell.collapseCellMinHeight * 3

    var totalHeight: CGFloat = 0
    for body in bodies {
        let height = BodyHeightForComment(
            viewModel: body,
            width: width,
            webviewCache: nil,
            imageCache: nil
        )
        totalHeight += height
        if bodyIsCollapsible(body: body),
            totalHeight > cap,
            totalHeight - cap > minDelta {
            let collapsedBodyHeight = max(cap - (totalHeight - height), IssueCommentBaseCell.collapseCellMinHeight)
            return (body, collapsedBodyHeight)
        }
    }
    return nil
}
