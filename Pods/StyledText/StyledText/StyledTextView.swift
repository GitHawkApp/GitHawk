//
//  StyledTextView.swift
//  StyledText
//
//  Created by Ryan Nystrom on 12/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

public protocol StyledTextViewDelegate: class {
    func didTap(view: StyledTextView, attributes: [NSAttributedStringKey: Any], point: CGPoint)
    func didLongPress(view: StyledTextView, attributes: [NSAttributedStringKey: Any], point: CGPoint)
}

open class StyledTextView: UIView {

    open weak var delegate: StyledTextViewDelegate?
    open var gesturableAttributes = Set<NSAttributedStringKey>()

    private var renderer: StyledTextRenderer?
    private var tapGesture: UITapGestureRecognizer?
    private var longPressGesture: UILongPressGestureRecognizer?

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
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

    override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
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
        let point = recognizer.location(in: self)
        guard let attributes = renderer?.attributes(at: point) else { return }
        delegate?.didTap(view: self, attributes: attributes, point: point)
    }

    @objc func onLong(recognizer: UILongPressGestureRecognizer) {
        let point = recognizer.location(in: self)
        guard recognizer.state == .began,
            let attributes = renderer?.attributes(at: point)
            else { return }
        delegate?.didLongPress(view: self, attributes: attributes, point: point)
    }

    // MARK: Public API

    open func configure(renderer: StyledTextRenderer, width: CGFloat) {
        self.renderer = renderer
        layer.contentsScale = renderer.scale
        reposition(width: width)
        accessibilityLabel = renderer.string.allText
    }

    open func reposition(width: CGFloat) {
        guard let renderer = self.renderer else { return }
        let result = renderer.render(
            contentSizeCategory: UIApplication.shared.preferredContentSizeCategory,
            width: width
        )
        layer.contents = result.image
        frame = UIEdgeInsetsInsetRect(CGRect(origin: .zero, size: result.size), renderer.inset)
    }

}
