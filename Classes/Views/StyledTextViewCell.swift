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

    

    private let textView = StyledTextView()

    override init(frame: CGRect) {
        super.init(frame: frame)
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

    // MARK: Public API

    final func set(renderer: StyledTextRenderer) {
        textView.configure(renderer: renderer, width: contentView.bounds.width)
    }

    // MARK: StyledTextViewDelegate

    func didTap(view: StyledTextView, attributes: [NSAttributedStringKey: Any], point: CGPoint) {

    }

    func didLongPress(view: StyledTextView, attributes: [NSAttributedStringKey: Any], point: CGPoint) {

    }

}
