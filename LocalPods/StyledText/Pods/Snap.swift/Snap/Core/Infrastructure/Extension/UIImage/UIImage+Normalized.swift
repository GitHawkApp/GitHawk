import UIKit

extension UIImage {
  var normalizedImage: Data? {
    defer {
      UIGraphicsEndImageContext()
    }
    
    let pixelSize = CGSize(width: size.width * scale, height: size.height * scale)
    UIGraphicsBeginImageContext(pixelSize)
    
    draw(in: CGRect(x: 0, y: 0, width: pixelSize.width, height: pixelSize.height))
   
    guard let drawnImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
    return UIImagePNGRepresentation(drawnImage)
  }
}
