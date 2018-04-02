//
//  Node+Elements.swift
//  cmark-gfm-swift
//
//  Created by Ryan Nystrom on 3/31/18.
//

import Foundation

struct FoldingOptions {
    var quoteLevel: Int
}

extension Block {
    func folded(_ options: FoldingOptions) -> [Element] {
        switch self {
        case .blockQuote(let items):
            var deeper = options
            deeper.quoteLevel += 1
            return items.flatMap { $0.folded(deeper) }
        case .codeBlock(let text, let language):
            return [.codeBlock(text: text, language: language)]
        case .custom:
            return []
        case .heading(let text, let level):
            return [.heading(text: text.textElements, level: level)]
        case .html(let text):
            return [.html(text: text)]
        case .list(let items, let type):
            return [.list(items: items.flatMap { $0.listElements(0) }, type: type)]
        case .paragraph(let text):
            let builder = InlineBuilder(options: options)
            text.forEach { $0.fold(builder: builder) }
            // clean up and append leftover text elements
            var els = builder.elements
            if let currentText = builder.currentText {
                els.append(currentText)
            }
            return els
        case .table(let items):
            return [.table(rows: items.flatMap { $0.tableRow })]
        case .tableHeader, .tableRow, .tableCell:
            return [] // handled in flattening .table
        case .thematicBreak:
            return [.hr]
        }
    }
}

class InlineBuilder {
    let options: FoldingOptions
    var elements = [Element]()
    var text = [TextElement]()
    init(options: FoldingOptions) {
        self.options = options
    }
    var currentText: Element? {
        guard text.count > 0 else { return nil }
        return options.quoteLevel > 0
            ? .quote(items: text, level: options.quoteLevel)
            : .text(items: text)
    }
    func pushNonText(_ el: Element) {
        if let currentText = self.currentText {
            elements.append(currentText)
            text.removeAll()
        }
        elements.append(el)
    }
}

extension Inline {
    /// Collapse all text elements, break by image and html elements
    func fold(builder: InlineBuilder) {
        switch self {
        case .text, .softBreak, .lineBreak, .code, .emphasis, .strong,
             .custom, .link, .strikethrough, .mention, .checkbox:
            if let el = textElement {
                builder.text.append(el)
            }
        case .image(_, let title, let url):
            if let title = title, let url = url {
                builder.pushNonText(.image(title: title, url: url))
            }
        case .html(let text):
            builder.pushNonText(.html(text: text))
        }
    }
}

public extension Node {

    var flatElements: [Element] {
        return elements.flatMap { $0.folded(FoldingOptions(quoteLevel: 0)) }
    }

}
