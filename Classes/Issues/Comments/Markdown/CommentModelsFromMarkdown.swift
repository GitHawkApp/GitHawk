//
//  CommentModelsFromMarkdown.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import MMMarkdown

private let newlineString = "\n"
private let bulletString = "\u{2022}"

func createCommentAST(markdown: String) -> MMDocument? {
    let parser = MMParser(extensions: .gitHubFlavored)
    var error: NSError? = nil
    let document = parser.parseMarkdown(markdown, error: &error)
    if let error = error {
        print("Error parsing markdown: %@", error.localizedDescription)
    }
    return document
}

func commentModels(markdown: String, width: CGFloat) -> [ListDiffable] {
    guard let document = createCommentAST(markdown: markdown) else { return [] }

    var results = [ListDiffable]()

    let baseAttributes: [String: Any] = [
        NSFontAttributeName: Styles.Fonts.body,
        NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color,
        NSParagraphStyleAttributeName: {
            let para = NSMutableParagraphStyle()
            para.paragraphSpacingBefore = 12;
            return para
        }(),
        NSBackgroundColorAttributeName: UIColor.white
    ]

    let seedString = NSMutableAttributedString()

    for element in document.elements {
        travelAST(
            markdown: document.markdown,
            element: element,
            attributedString: seedString,
            attributeStack: baseAttributes,
            width: width,
            listLevel: 0,
            quoteLevel: 0,
            results: &results
        )
    }

    // add any remaining text
    if seedString.length > 0 {
        results.append(createTextModel(attributedString: seedString, width: width))
    }

    return results
}

func createTextModel(
    attributedString: NSAttributedString,
    width: CGFloat
    ) -> NSAttributedStringSizing {
    // remove head/tail whitespace and newline from text blocks
    let trimmedString = attributedString
        .attributedStringByTrimmingCharacterSet(charSet: .whitespacesAndNewlines)
    return NSAttributedStringSizing(
        containerWidth: width,
        attributedText: trimmedString,
        inset: IssueCommentTextCell.inset
    )
}

func createQuoteModel(
    level: Int,
    attributedString: NSAttributedString,
    width: CGFloat
    ) -> IssueCommentQuoteModel {
    // remove head/tail whitespace and newline from text blocks
    let trimmedString = attributedString
        .attributedStringByTrimmingCharacterSet(charSet: .whitespacesAndNewlines)
    let text = NSAttributedStringSizing(
        containerWidth: width,
        attributedText: trimmedString,
        inset: IssueCommentQuoteCell.inset(quoteLevel: level)
    )
    return IssueCommentQuoteModel(level: level, quote: text)
}

func substringOrNewline(text: String, range: NSRange) -> String {
    let substring = text.substring(with: range) ?? ""
    if substring.characters.count > 0 {
        return substring
    } else {
        return newlineString
    }
}

func typeNeedsNewline(type: MMElementType) -> Bool {
    switch type {
    case .paragraph: return true
    case .listItem: return true
    case .header: return true
    default: return false
    }
}

func createModel(markdown: String, element: MMElement) -> ListDiffable? {
    switch element.type {
    case .codeBlock:
        return element.codeBlock(markdown: markdown)
    case .image:
        return element.imageModel
    case .table:
        return IssueCommentUnsupportedModel(name: "Table")
    case .HTML:
        guard let html = markdown.substring(with: element.range) else { return nil }
        return IssueCommentHtmlModel(html: html)
    case .horizontalRule:
        return IssueCommentHrModel()
    default: return nil
    }
}

func isList(type: MMElementType) -> Bool {
    switch type {
    case .bulletedList, .numberedList: return true
    default: return false
    }
}

func travelAST(
    markdown: String,
    element: MMElement,
    attributedString: NSMutableAttributedString,
    attributeStack: [String: Any],
    width: CGFloat,
    listLevel: Int,
    quoteLevel: Int,
    results: inout [ListDiffable]
    ) {
    let nextListLevel = listLevel + (isList(type: element.type) ? 1 : 0)

    let isQuote = element.type == .blockquote
    let nextQuoteLevel = quoteLevel + (isQuote ? 1 : 0)

    // push more text attributes on the stack the deeper we go
    let pushedAttributes = element.attributes(currentAttributes: attributeStack, listLevel: nextListLevel)

    if typeNeedsNewline(type: element.type) {
        attributedString.append(NSAttributedString(string: newlineString, attributes: pushedAttributes))
    }

    // if entering a block quote, finish up any string that was building
    if isQuote && attributedString.length > 0 {
        if quoteLevel > 0 {
            results.append(createQuoteModel(level: quoteLevel, attributedString: attributedString, width: width))
        } else {
            results.append(createTextModel(attributedString: attributedString, width: width))
        }
        attributedString.removeAll()
    }

    if element.type == .none {
        let substring = substringOrNewline(text: markdown, range: element.range)
        attributedString.append(NSAttributedString(string: substring, attributes: pushedAttributes))
    } else if element.type == .lineBreak {
        attributedString.append(NSAttributedString(string: newlineString, attributes: pushedAttributes))
    } else if element.type == .listItem {
        // append list styles at the beginning of each list item
        let isInsideBulletedList = element.parent?.type == .bulletedList
        let modifier: String
        if isInsideBulletedList {
            modifier = "\(bulletString) "
        } else if element.numberedListPosition > 0 {
            modifier = "\(element.numberedListPosition). "
        } else {
            modifier = ""
        }
        attributedString.append(NSAttributedString(string: modifier, attributes: pushedAttributes))
    }

    let model = createModel(markdown: markdown, element: element)

    // if a model exists, push a new model with the current text stack _before_ the model. remember to drain the text
    if let model = model {
        results.append(createTextModel(attributedString: attributedString, width: width))
        results.append(model)
        attributedString.removeAll()
    } else {
        for child in element.children {
            travelAST(
                markdown: markdown,
                element: child,
                attributedString: attributedString,
                attributeStack: pushedAttributes,
                width: width,
                listLevel: nextListLevel,
                quoteLevel: nextQuoteLevel,
                results: &results
            )
        }
    }

    // cap the child before exiting
    if isQuote && attributedString.length > 0 {
        results.append(createQuoteModel(level: nextQuoteLevel, attributedString: attributedString, width: width))
        attributedString.removeAll()
    }
}
