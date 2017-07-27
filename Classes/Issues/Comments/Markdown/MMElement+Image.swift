//
//  MMElement+Image.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import MMMarkdown

func CreateImageModel(element: MMElement) -> IssueCommentImageModel? {
    guard let href = element.href, let url = URL(string: href) else { return nil }
    return IssueCommentImageModel(url: url)
}
