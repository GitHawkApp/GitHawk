//
//  AttributedStringView.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/23/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

protocol AttributedStringViewDelegate: class {
    func didTapURL(view: AttributedStringView, url: URL)
}

final class AttributedStringView: UIView {

    var delegate: AttributedStringViewDelegate? = nil

    private var text: NSAttributedStringSizing? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        isOpaque = true
        layer.contentsGravity = kCAGravityTopLeft

        let tap = UITapGestureRecognizer(target: self, action: #selector(AttributedStringView.onTap(recognizer:)))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public API

    func configureAndSizeToFit(text: NSAttributedStringSizing) {
        self.text = text

        let width = bounds.width
        layer.contentsScale = text.screenScale
        layer.contents = text.contents(width)
        
        let rect = CGRect(origin: .zero, size: text.textViewSize(width))
        frame = UIEdgeInsetsInsetRect(rect, text.inset)
    }

    // MARK: Private API

    func onTap(recognizer: UITapGestureRecognizer) {
        guard let urlString = text?.attributes(point: recognizer.location(in: self))?[MarkdownURLName] as? String,
            let url = URL(string: urlString)
            else { return }
        delegate?.didTapURL(view: self, url: url)
    }

}
