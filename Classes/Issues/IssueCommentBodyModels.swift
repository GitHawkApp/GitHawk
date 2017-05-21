//
//  IssueCommentBodyModels.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/21/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

private func sizingString(
    body: String,
    width: CGFloat,
    startIndex: String.Index,
    endIndex: String.Index
    ) -> NSAttributedStringSizing {
    let between = body.substring(with: startIndex..<endIndex)
    let attributedString = NSAttributedString(
        string: between,
        attributes: [
            NSFontAttributeName: Styles.Fonts.body,
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark
        ])
    return NSAttributedStringSizing(
        containerWidth: width,
        attributedText: attributedString,
        inset: IssueCommentTextCell.inset
    )
}

private let imageRegex = try! NSRegularExpression(pattern: "!\\[.+]\\((.+)\\)", options: [])

func createCommentModels(body: String, width: CGFloat) -> [IGListDiffable] {

    var result = [IGListDiffable]()

    let matches = imageRegex.matches(in: body, options: [], range: NSRange(location: 0, length: body.characters.count))
    var location = body.startIndex

    for match in matches {
        let betweenEnd = body.index(body.startIndex, offsetBy: match.range.location)
        let sizing = sizingString(body: body, width: width, startIndex: location, endIndex: betweenEnd)
        result.append(sizing)

        location = body.index(betweenEnd, offsetBy: match.range.length)

        let imageRange = match.rangeAt(1)
        let imageBegin = body.index(body.startIndex, offsetBy: imageRange.location)
        let imageEnd = body.index(imageBegin, offsetBy: imageRange.length)
        let imageURLString = body.substring(with: imageBegin..<imageEnd)
        if let url = URL(string: imageURLString) {
            result.append(IssueCommentImageModel(url: url))
        }
    }

    let remaining = sizingString(body: body, width: width, startIndex: location, endIndex: body.endIndex)
    result.append(remaining)
    
    return result
}

