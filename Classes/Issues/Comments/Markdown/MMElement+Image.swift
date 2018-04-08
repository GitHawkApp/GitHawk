//
//  MMElement+Image.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import MMMarkdown
import IGListKit

func CreateImageModel(href: String?, title: String? = nil) -> ListDiffable? {
    guard let href = href, let url = URL(string: href) else { return nil }
    if url.pathExtension.lowercased() == "svg" {
        // hack to workaround the SDWebImage not supporting svg images
        // just render it in a webview
        return IssueCommentHtmlModel(html: "<img src=\(href) />")
    } else {
        return IssueCommentImageModel(url: url, title: title)
    }
}
