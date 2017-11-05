//
//  AttributedStringCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

// built for subclassing and implementing your own ListBindable conformance
class AttributedStringCell: UICollectionViewCell {

    private let textView = AttributedStringView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(textView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
        textView.reposition(width: contentView.bounds.width)
    }

    // MARK: Public API

    final var delegate: AttributedStringViewDelegate? {
        set {
            textView.delegate = newValue
        }
        get {
            return textView.delegate
        }
    }

    final func set(attributedText: NSAttributedStringSizing) {
        textView.configureAndSizeToFit(text: attributedText, width: contentView.bounds.width)
    }

}
