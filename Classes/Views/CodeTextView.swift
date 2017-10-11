//
//  CodeTextView.swift
//  Freetime
//
//  Created by Weyert de Boer on 12/10/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class CodeTextView: UIView, UITextViewDelegate {

    private var textView: UITextView = UITextView()

    private var numViewWidth: CGFloat = 30.0

    public var isEditable = false {
        didSet {
            textView.isEditable = isEditable
        }
    }

    public var attributedText: NSAttributedString? {
        didSet {
            textView.attributedText = attributedText
            self.setNeedsDisplay()
        }
    }

    override var backgroundColor: UIColor? {
        didSet {
            self.textView.backgroundColor = backgroundColor
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup();
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        print("setup()")
        contentMode = .redraw
        backgroundColor = .red

        textView.delegate = self
        addSubview(textView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
