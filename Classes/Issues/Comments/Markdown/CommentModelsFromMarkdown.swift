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

func createCommentAST(markdown: String) -> MMDocument? {
    let parser = MMParser(extensions: .gitHubFlavored)
    var error: NSError? = nil
    let document = parser.parseMarkdown(markdown, error: &error)
    if let error = error {
        print("Error parsing markdown: %@", error.localizedDescription)
    }
    return document
}

func commentModels(markdown: String, width: CGFloat) -> [IGListDiffable] {
    guard let document = createCommentAST(markdown: markdown) else { return [] }

    var results = [IGListDiffable]()

    let baseAttributes: [String: Any] = [
        NSFontAttributeName: Styles.Fonts.body,
        NSForegroundColorAttributeName: Styles.Colors.Gray.dark,
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
            indentLevel: 0,
            results: &results
        )
    }

    // add any remaining text
    if seedString.length > 0 {
        results.append(createTextModel(attributedString: seedString, width: width))
    }

    return results
}

private func merge(left: [String: Any], right: [String: Any]) -> [String: Any] {
    var l = left
    for (k, v) in right {
        l[k] = v
    }
    return l
}

private func createTextModel(
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

private func substringOrNewline(text: String, range: NSRange) -> String {
    let substring = text.substring(with: range) ?? ""
    if substring.characters.count > 0 {
        return substring
    } else {
        return "\n"
    }
}

private func typeNeedsNewline(type: MMElementType) -> Bool {
    switch type {
    case .paragraph: return true
    case .listItem: return true
    case .header: return true
    default: return false
    }
}

private func createModel(markdown: String, element: MMElement) -> IGListDiffable? {
    switch element.type {
    case .codeBlock:
        return createCodeBlock(markdown: markdown, element: element)
    case .image:
        return createImage(element: element)
    default: return nil
    }
}

private func isList(type: MMElementType) -> Bool {
    switch type {
    case .bulletedList, .numberedList: return true
    default: return false
    }
}

private func travelAST(
    markdown: String,
    element: MMElement,
    attributedString: NSMutableAttributedString,
    attributeStack: [String: Any],
    width: CGFloat,
    indentLevel: Int,
    results: inout [IGListDiffable]
    ) {
    let nextIndentLevel = indentLevel + (isList(type: element.type) ? 1 : 0)

    // push more text attributes on the stack the deeper we go
    let pushedAttributes = pushAttributes(element: element, stack: attributeStack, indentLevel: nextIndentLevel)

    if typeNeedsNewline(type: element.type) {
        attributedString.append(NSAttributedString(string: "\n", attributes: pushedAttributes))
    }

    if element.type == .none {
        let substring = substringOrNewline(text: markdown, range: element.range)
        attributedString.append(NSAttributedString(string: substring, attributes: pushedAttributes))
    } else if element.type == .lineBreak {
        attributedString.append(NSAttributedString(string: "\n", attributes: pushedAttributes))
    } else if element.type == .listItem {
        // append list styles at the beginning of each list item
        let isInsideBulletedList = element.parent?.type == .bulletedList
        let modifier: String
        if isInsideBulletedList {
            modifier = "\u{2022} "
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
        attributedString.deleteCharacters(in: attributedString.string.nsrange)
        results.append(model)
    } else {
        for child in element.children {
            travelAST(
                markdown: markdown,
                element: child,
                attributedString: attributedString,
                attributeStack: pushedAttributes,
                width: width,
                indentLevel: nextIndentLevel,
                results: &results
            )
        }
    }
}

private func createCodeBlock(
    markdown: String,
    element: MMElement
    ) -> IssueCommentCodeBlockModel {
    guard element.type == .codeBlock else {
        fatalError("Passing non-code block element to create function")
    }

    // create the text from all 1d "none" child elements
    // code blocks should not have any other child element type aside from "entity", which is skipped
    let text = element.children.reduce("") {
        guard $1.type == .none else { return $0 }
        return $0 + substringOrNewline(text: markdown, range: $1.range)
    }.trimmingCharacters(in: .whitespacesAndNewlines)

    var inset = IssueCommentCodeBlockCell.textViewInset
    inset.left += IssueCommentCodeBlockCell.scrollViewInset.left
    inset.right += IssueCommentCodeBlockCell.scrollViewInset.right

    let attributes: [String: Any] = [
        NSForegroundColorAttributeName: Styles.Colors.Gray.dark,
        NSFontAttributeName: Styles.Fonts.code
    ]

    let stringSizing = NSAttributedStringSizing(
        containerWidth: 0,
        attributedText: NSAttributedString(string: text, attributes: attributes),
        inset: inset
    )
    return IssueCommentCodeBlockModel(
        code: stringSizing,
        language: element.language
    )
}

private func createImage(element: MMElement) -> IssueCommentImageModel? {
    guard element.type == .image  else {
        fatalError("Passing non-image element to create function")
    }
    guard let href = element.href, let url = URL(string: href) else { return nil }
    return IssueCommentImageModel(url: url)
}

extension UIFont {

    func addingTraits(traits: UIFontDescriptorSymbolicTraits) -> UIFont {
        let newTraits = fontDescriptor.symbolicTraits.union(traits)
        guard let descriptor = fontDescriptor.withSymbolicTraits(newTraits)
            else { return self }
        return UIFont(descriptor: descriptor, size: 0)
    }

}

private func pushAttributes(
    element: MMElement,
    stack: [String: Any],
    indentLevel: Int
    ) -> [String: Any] {
    let currentFont: UIFont = stack[NSFontAttributeName] as? UIFont ?? Styles.Fonts.body

    let currentPara: NSMutableParagraphStyle
    if let para = (stack[NSParagraphStyleAttributeName] as? NSParagraphStyle)?.mutableCopy() as? NSMutableParagraphStyle {
        currentPara = para
    } else {
        currentPara = NSMutableParagraphStyle()
    }

    let newAttributes: [String: Any]
    switch element.type {
    case .strikethrough: newAttributes = [
        NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
        NSStrikethroughColorAttributeName: stack[NSForegroundColorAttributeName] ?? Styles.Colors.Gray.dark,
        ]
    case .strong: newAttributes = [
        NSFontAttributeName: currentFont.addingTraits(traits: .traitBold),
        ]
    case .em: newAttributes = [
        NSFontAttributeName: currentFont.addingTraits(traits: .traitItalic),
        ]
    case .codeSpan: newAttributes = [
        NSFontAttributeName: Styles.Fonts.code,
        NSBackgroundColorAttributeName: Styles.Colors.Gray.lighter,
        NSForegroundColorAttributeName: Styles.Colors.Gray.dark,
        ]
    case .link: newAttributes = [
        NSForegroundColorAttributeName: Styles.Colors.Blue.medium,
        "FIXME": element.href ?? "",
        ]
    case .header:
        switch element.level {
        case 1: newAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 24),
            ]
        case 2: newAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 22),
            ]
        case 3: newAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20),
            ]
        case 4: newAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18),
            ]
        case 5: newAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16),
            ]
        default: newAttributes = [
            NSForegroundColorAttributeName: Styles.Colors.Gray.medium,
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16),
            ]
        }
    case .bulletedList, .numberedList:
        let indent: CGFloat = (CGFloat(indentLevel) - 1) * 18
        currentPara.firstLineHeadIndent = indent
        currentPara.firstLineHeadIndent = indent
        newAttributes = [NSParagraphStyleAttributeName: currentPara]
    default: newAttributes = [:]
    }
    return merge(left: stack, right: newAttributes)
}
