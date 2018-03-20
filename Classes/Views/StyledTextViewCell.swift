//
//  StyledTextViewCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 3/17/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import StyledText

protocol StyledTextViewCellDelegate: class {
    func didTap(cell: StyledTextViewCell, attribute: DetectedMarkdownAttribute)
}

class StyledTextViewCell: UICollectionViewCell, StyledTextViewDelegate {

    weak var delegate: StyledTextViewCellDelegate?

    private let textView = StyledTextView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        textView.delegate = self
        textView.gesturableAttributes = MarkdownAttribute.all
        contentView.addSubview(textView)
        isAccessibilityElement = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
        textView.reposition(width: contentView.bounds.width)
    }

    override var accessibilityLabel: String? {
        get { return AccessibilityHelper.generatedLabel(forCell: self)}
        set {}
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    // MARK: Public API

    final func set(renderer: StyledTextRenderer) {
        textView.configure(renderer: renderer, width: contentView.bounds.width)
    }

    // MARK: StyledTextViewDelegate

    func didTap(view: StyledTextView, attributes: [NSAttributedStringKey: Any], point: CGPoint) {
        guard let detected = DetectMarkdownAttribute(attributes: attributes) else { return }
        delegate?.didTap(cell: self, attribute: detected)
    }

    func didLongPress(view: StyledTextView, attributes: [NSAttributedStringKey: Any], point: CGPoint) {
        if let details = attributes[MarkdownAttribute.details] as? String {
            showDetailsInMenu(details: details, point: point)
        }
    }

}
