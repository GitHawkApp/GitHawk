//
//  QuotedComment.swift
//  Freetime
//
//  Created by Joan Disho on 09.05.18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

class QuotedComment {
    private let feed: Feed
    private let commentModel: IssueCommentModel

    init(feed: Feed, commentModel: IssueCommentModel) {
        self.feed = feed
        self.commentModel = commentModel
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var quote: String {
        let text = commentModel.rawMarkdown.substringUntilNewLine()
        return ">\(text)\n\n@\(commentModel.details.login)"
    }

    func scrollInto() {
        feed.adapter.scroll(to: commentModel, padding: Styles.Sizes.rowSpacing)
    }
}
