//
//  MarkdownName.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

enum MarkdownAttribute {
    static let url = NSAttributedStringKey(rawValue: "com.freetime.Markdown.url-name")
    static let email = NSAttributedStringKey(rawValue: "com.freetime.Markdown.email-name")
    static let username = NSAttributedStringKey(rawValue: "com.freetime.Markdown.username-name")
    static let usernameDisabled = NSAttributedStringKey(rawValue: "com.freetime.Markdown.username-disabled-name")
    static let linkShorteningDisabled = NSAttributedStringKey(rawValue: "com.freetime.Markdown.link-shortening-disabled-name")
    static let issue = NSAttributedStringKey(rawValue: "com.freetime.Markdown.issue")
    static let details = NSAttributedStringKey(rawValue: "com.freetime.Markdown.details")
}
