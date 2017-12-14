import UIKit

extension UIImage {
  /// Get the difference between two images by applying a blend mode on top
  /// [Original source](https://github.com/facebookarchive/ios-snapshot-test-case/blob/master/FBSnapshotTestCase/Categories/UIImage%2BDiff.m)
  func diff(with image: UIImage) -> UIImage? {
    guard let oldImageContext = context(for: self) else { return nil }
    let rect = getMaximumRect(with: image)
    
    // Draw old image
    oldImageContext.draw(cgImage!, in: rect)
    
    // Set alpha for drawing the new image on top of the old
    oldImageContext.setAlpha(0.5)
    oldImageContext.beginTransparencyLayer(auxiliaryInfo: nil)
    
    // Draw new image with blend mode set `difference`
    oldImageContext.draw(image.cgImage!, in: rect)
    oldImageContext.setBlendMode(.difference)
    oldImageContext.setFillColor(UIColor.white.cgColor)
    oldImageContext.fill(rect)
    oldImageContext.endTransparencyLayer()
    
    guard let diffedCgImage = oldImageContext.makeImage() else { return nil }
    return UIImage(cgImage: diffedCgImage)
  }
  
  private func getMaximumRect(with image: UIImage) -> CGRect {
    return CGRect(x: 0, y: 0, width: max(cgImage!.width, image.cgImage!.width), height: max(cgImage!.height, image.cgImage!.width))
  }
}
