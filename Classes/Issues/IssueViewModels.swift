//
//  IssueViewModels.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

private func createViewModels(_ issue: Issue, width: CGFloat) -> [IGListDiffable] {
    var result = [IGListDiffable]()
    result.append(createIssueTitleString(issue: issue, width: width))

    result.append(IssueLabelsModel(labels: issue.labels ?? []))

    if let root = createRootIssueComment(issue: issue, width: width) {
        result.append(root)
    }

    return result
}

func createViewModels(issue: Issue, width: CGFloat, completion: @escaping ([IGListDiffable]) -> ()) {
    DispatchQueue.global().async {
        let result = createViewModels(issue, width: width)
        DispatchQueue.main.async {
            completion(result)
        }
    }
}

func createIssueTitleString(issue: Issue, width: CGFloat) -> NSAttributedStringSizing {
    let attributedString = NSAttributedString(
        string: issue.title ?? "",
        attributes: [
            NSFontAttributeName: Styles.Fonts.headline,
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark
        ])
    return NSAttributedStringSizing(
        containerWidth: width,
        attributedText: attributedString,
        inset: IssueTitleCell.inset
    )
}

func sizingString(
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

        let imageRange = match.rangeAt(1)
        let imageBegin = body.index(body.startIndex, offsetBy: imageRange.location)
        let imageEnd = body.index(imageBegin, offsetBy: imageRange.length)
        let image = body.substring(with: imageBegin..<imageEnd)
        result.append(image as IGListDiffable)

        location = body.index(betweenEnd, offsetBy: match.range.length)
    }

    let remaining = sizingString(body: body, width: width, startIndex: location, endIndex: body.endIndex)
    result.append(remaining)

    return result
}

func createRootIssueComment(issue: Issue, width: CGFloat) -> IssueCommentModel? {
    guard let id = issue.id?.intValue,
        let created = issue.created_at,
        let date = GithubAPIDateFormatter().date(from: created),
        let login = issue.user?.login,
        let avatar = issue.user?.avatar_url,
        let avatarURL = URL(string: avatar)
        else { return nil }

    let details = IssueCommentDetailsViewModel(date: date, login: login, avatarURL: avatarURL)
    let bodies = createCommentModels(body: issue.body ?? "", width: width)
    return IssueCommentModel(id: id, details: details, bodyModels: bodies)
}
