import Foundation

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

extension Layout
{
#if os(iOS) || os(tvOS)
    /// Apply the layout to the given view hierarchy.
    public func apply(_ view: UIView, scale: CGFloat = UIScreen.main.scale)
    {
        view.frame = _roundPixel(frame, scale: scale)

        for (subview, layout) in zip(view.subviews, children) {
            layout.apply(subview)
        }
    }
#elseif os(macOS)
    /// Apply the layout to the given view hierarchy.
    public func apply(_ view: NSView, scale: CGFloat = NSScreen.main?.backingScaleFactor ?? 1)
    {
        view.frame = _roundPixel(frame, scale: scale)

        for (subview, layout) in zip(view.subviews, children) {
            layout.apply(subview)
        }
    }
#endif
}

/// Pixel-perfect rounding that is better than dangerous `CGRectIntegral`.
private func _roundPixel(_ value: CGFloat, scale: CGFloat) -> CGFloat
{
    return round(value * scale) / scale
}

private func _roundPixel(_ rect: CGRect, scale: CGFloat) -> CGRect
{
    return CGRect(
        x: _roundPixel(rect.origin.x, scale: scale),
        y: _roundPixel(rect.origin.y, scale: scale),
        width: _roundPixel(rect.size.width, scale: scale),
        height: _roundPixel(rect.size.height, scale: scale)
    )
}
