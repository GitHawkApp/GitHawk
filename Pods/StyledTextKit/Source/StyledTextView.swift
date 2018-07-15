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
    open var drawsAsync = false

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

    // MARK: Overrides

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

        var firstRect: CGRect = CGRect.null
        var bodyRect: CGRect = CGRect.null
        var lastRect: CGRect = CGRect.null

        let path = UIBezierPath()

        renderer.layoutManager.enumerateEnclosingRects(
            forGlyphRange: range,
            withinSelectedGlyphRange: NSRange(location: NSNotFound, length: 0),
            in: renderer.textContainer
        ) { (rect, stop) in
            if firstRect.isNull {
                firstRect = rect
            } else if lastRect.isNull {
                lastRect = rect
            } else {
                // We have a lastRect that was previously filled, now it needs to be dumped into the body
                bodyRect = lastRect.intersection(bodyRect)
                // and save the current rect as the new "lastRect"
                lastRect = rect
            }
        }

        if !firstRect.isNull {
            path.append(UIBezierPath(roundedRect: firstRect.insetBy(dx: -2, dy: -2), cornerRadius: 3))
        }
        if !bodyRect.isNull {
            path.append(UIBezierPath(roundedRect: bodyRect.insetBy(dx: -2, dy: -2), cornerRadius: 3))
        }
        if !lastRect.isNull {
            path.append(UIBezierPath(roundedRect: lastRect.insetBy(dx: -2, dy: -2), cornerRadius: 3))
        }

        highlightLayer.frame = bounds
        highlightLayer.path = path.cgPath
    }

    private func clearHighlight() {
        highlightLayer.path = nil
    }

    private func setRenderResults(renderer: StyledTextRenderer, result: (CGImage?, CGSize)) {
        layer.contents = result.0
        frame = CGRect(origin: CGPoint(x: renderer.inset.left, y: renderer.inset.top), size: result.1)
    }

    static var renderQueue = DispatchQueue(
      label: "com.whoisryannystrom.StyledText.renderQueue",
      qos: .default, attributes: DispatchQueue.Attributes(rawValue: 0),
      autoreleaseFrequency: .workItem, 
      target: nil
    )

    // MARK: Public API

    open func configure(with renderer: StyledTextRenderer, width: CGFloat) {
        self.renderer = renderer
        layer.contentsScale = renderer.scale
        reposition(for: width)
        accessibilityLabel = renderer.string.allText
    }

    open func reposition(for width: CGFloat) {
        guard let capturedRenderer = self.renderer else { return }
        // First, we check if we can immediately apply a previously cached render result.
        let cachedResult = capturedRenderer.cachedRender(for: width)
        if let cachedImage = cachedResult.image, let cachedSize = cachedResult.size {
            setRenderResults(renderer: capturedRenderer, result: (cachedImage, cachedSize))
            return
        }

        // We have to do a full render, so if we are drawing async it's time to dispatch:
        if drawsAsync {
            StyledTextView.renderQueue.async {
                // Compute the render result (sizing and rendering to an image) on a bg thread
                let result = capturedRenderer.render(for: width)
                DispatchQueue.main.async {
                    // If the renderer changed, then our computed result is now invalid, so we have to throw it out.
                    if capturedRenderer !== self.renderer { return }
                    // If the renderer hasn't changed, we're OK to actually apply the result of our computation.
                    self.setRenderResults(renderer: capturedRenderer, result: result)
                }
            }
        } else {
            // We're in fully-synchronous mode. Immediately compute the result and set it.
            let result = capturedRenderer.render(for: width)
            setRenderResults(renderer: capturedRenderer, result: result)
        }
    }
}
