import UIKit

extension CALayer {
  /// Extract image from CALayer
  func image() -> UIImage? {
    defer {
      UIGraphicsEndImageContext()
    }
    UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, contentsScale)
    guard let context = UIGraphicsGetCurrentContext() else { return nil }
    render(in: context)
    return UIGraphicsGetImageFromCurrentImageContext()
  }
}
