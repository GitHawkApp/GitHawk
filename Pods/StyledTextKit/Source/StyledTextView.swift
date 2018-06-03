//
//  StyledTextKitView.swift
//  StyledTextKit
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
    private var highlightLayer = CAShapeLayer()

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

        layer.contentsGravity = kCAGravityTopLeft

        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(recognizer:)))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
        self.tapGesture = tap

        let long = UILongPressGestureRecognizer(target: self, action: #selector(onLong(recognizer:)))
        addGestureRecognizer(long)
        self.longPressGesture = long

        self.highlightColor = UIColor.black.withAlphaComponent(0.1)
        layer.addSublayer(highlightLayer)
    }

    public var highlightColor: UIColor? {
        get {
            guard let color = highlightLayer.fillColor else { return nil }
            return UIColor(cgColor: color)
        }
        set { highlightLayer.fillColor = newValue?.cgColor }
    }

    // MARK: Overries

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        highlight(at: touch.location(in: self))
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        clearHighlight()
    }

    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        clearHighlight()
    }

    // MARK: UIGestureRecognizerDelegate

    override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard (gestureRecognizer === tapGesture || gestureRecognizer === longPressGesture),
            let attributes = renderer?.attributes(at: gestureRecognizer.location(in: self)) else {
                return super.gestureRecognizerShouldBegin(gestureRecognizer)
        }
        for attribute in attributes.attributes {
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
        delegate?.didTap(view: self, attributes: attributes.attributes, point: point)
    }

    @objc func onLong(recognizer: UILongPressGestureRecognizer) {
        let point = recognizer.location(in: self)
        guard recognizer.state == .began,
            let attributes = renderer?.attributes(at: point)
            else { return }

        delegate?.didLongPress(view: self, attributes: attributes.attributes, point: point)
    }

    private func highlight(at point: CGPoint) {
        guard let renderer = renderer,
            let attributes = renderer.attributes(at: point),
            attributes.attributes[.highlight] != nil
            else { return }

        let storage = renderer.storage
        let maxLen = storage.length
        var min = attributes.index
        var max = attributes.index

        storage.enumerateAttributes(
            in: NSRange(location: 0, length: attributes.index),
            options: .reverse
        ) { (attrs, range, stop) in
            if attrs[.highlight] != nil && min > 0 {
                min = range.location
            } else {
                stop.pointee = true
            }
        }

        storage.enumerateAttributes(
            in: NSRange(location: attributes.index, length: maxLen - attributes.index),
            options: []
        ){ (attrs, range, stop) in
            if attrs[.highlight] != nil && max < maxLen {
                max = range.location + range.length
            } else {
                stop.pointee = true
            }
        }

        let range = NSRange(location: min, length: max - min)

        let path = UIBezierPath()
        renderer.layoutManager.enumerateEnclosingRects(
            forGlyphRange: range,
            withinSelectedGlyphRange: NSRange(location: NSNotFound, length: 0),
            in: renderer.textContainer
        ) { (rect, stop) in
            path.append(UIBezierPath(roundedRect: rect.insetBy(dx: -2, dy: -2), cornerRadius: 3))
        }

        highlightLayer.frame = bounds
        highlightLayer.path = path.cgPath
    }

    private func clearHighlight() {
        highlightLayer.path = nil
    }

    // MARK: Public API

    open func configure(with renderer: StyledTextRenderer, width: CGFloat) {
        self.renderer = renderer
        layer.contentsScale = renderer.scale
        reposition(for: width)
        accessibilityLabel = renderer.string.allText
    }

    open func reposition(for width: CGFloat) {
        guard let renderer = self.renderer else { return }
        let result = renderer.render(for: width)
        layer.contents = result.image
        frame = CGRect(origin: CGPoint(x: renderer.inset.left, y: renderer.inset.top), size: result.size)
    }

}
