import UIKit

extension UIImage {
  /// Try to create a context from a given image
  func context(for image: UIImage) -> CGContext? {
    let imageSize = CGSize(width: image.cgImage!.width, height: image.cgImage!.height)
    return CGContext(
      data: nil,
      width: Int(imageSize.width),
      height: Int(imageSize.height),
      bitsPerComponent: image.cgImage!.bitsPerComponent,
      bytesPerRow: image.cgImage!.bytesPerRow,
      space: image.cgImage!.colorSpace!,
      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    )
  }
}
