//
//  MarkdownStyledTextView.swift
//  Freetime
//
//  Created by Ryan Nystrom on 3/19/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import StyledText

protocol MarkdownStyledTextViewDelegate: class {
    func didTap(cell: MarkdownStyledTextView, attribute: DetectedMarkdownAttribute)
}

class MarkdownStyledTextView: StyledTextView, StyledTextViewDelegate {

    weak var tapDelegate: MarkdownStyledTextViewDelegate?

    override var delegate: StyledTextViewDelegate? {
        get { return self }
        set {}
    }

    // MARK: StyledTextViewDelegate

    func didTap(view: StyledTextView, attributes: [NSAttributedStringKey: Any], point: CGPoint) {
        guard let detected = DetectMarkdownAttribute(attributes: attributes) else { return }
        tapDelegate?.didTap(cell: self, attribute: detected)
    }

    func didLongPress(view: StyledTextView, attributes: [NSAttributedStringKey: Any], point: CGPoint) {
        if let details = attributes[MarkdownAttribute.details] as? String {
            showDetailsInMenu(details: details, point: point)
        }
    }

}
