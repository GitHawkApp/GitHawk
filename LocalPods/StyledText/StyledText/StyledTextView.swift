//
//  StyledTextView.swift
//  StyledText
//
//  Created by Ryan Nystrom on 12/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

protocol StyledTextViewDelegate: class {
    func didTap(view: StyledTextView, attributes: [NSAttributedStringKey: Any])
}

final class StyledTextView: UIView {

    weak var delegate: StyledTextViewDelegate?

    private var renderer: StyledTextRenderer?
    private var tapGesture: UITapGestureRecognizer?
    private var longPressGesture: UILongPressGestureRecognizer?
    private var gesturableAttributes = Set<NSAttributedStringKey>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        isOpaque = true

        layer.contentsGravity = kCAGravityTopLeft

        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(recognizer:)))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
        self.tapGesture = tap

        let long = UILongPressGestureRecognizer(target: self, action: #selector(onLong(recognizer:)))
        addGestureRecognizer(long)
        self.longPressGesture = long
    }

    // MARK: UIGestureRecognizerDelegate

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard (gestureRecognizer === tapGesture || gestureRecognizer === longPressGesture),
            let attributes = renderer?.attributes(at: gestureRecognizer.location(in: self)) else {
                return super.gestureRecognizerShouldBegin(gestureRecognizer)
        }
        for attribute in attributes {
            if gesturableAttributes.contains(attribute.key) {
                return true
            }
        }
        return false
    }

    // MARK: Private API

    @objc func onTap(recognizer: UITapGestureRecognizer) {
        guard let attributes = renderer?.attributes(at: recognizer.location(in: self)) else { return }
        delegate?.didTap(view: self, attributes: attributes)
    }

    @objc func onLong(recognizer: UILongPressGestureRecognizer) {
        guard recognizer.state == .began else { return }
    }

    // MARK: Public API

    func configure(renderer: StyledTextRenderer, width: CGFloat) {
        self.renderer = renderer
        layer.contentsScale = renderer.scale
        reposition(width: width)
    }

    func reposition(width: CGFloat) {
        guard let renderer = self.renderer else { return }
        let result = renderer.render(
            contentSizeCategory: UIApplication.shared.preferredContentSizeCategory,
            width: width
        )
        layer.contents = result.image
        frame = UIEdgeInsetsInsetRect(CGRect(origin: .zero, size: result.size), renderer.inset)
    }

}
