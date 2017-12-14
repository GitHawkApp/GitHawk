import UIKit

extension UIView {
  /// Extract image data with the whole hierarchy from `UIView`
  func render() -> UIImage? {
    if #available(iOS 10.0, *) {
      let imageRendererFormat = UIGraphicsImageRendererFormat.default()
      imageRendererFormat.opaque = true
      let renderer = UIGraphicsImageRenderer(
        bounds: bounds
      )
      return renderer.image { context in
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        layer.render(in: context.cgContext)
      }
    }
 
    defer {
      UIGraphicsEndImageContext()
    }
    UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)

    let context = UIGraphicsGetCurrentContext()!
    drawHierarchy(in: bounds, afterScreenUpdates: true)
    layer.render(in: context)
    return UIGraphicsGetImageFromCurrentImageContext()
  }
}
