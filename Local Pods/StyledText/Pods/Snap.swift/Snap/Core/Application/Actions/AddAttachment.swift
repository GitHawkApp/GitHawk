import UIKit
import XCTest

struct AddAttachment {
  func execute(with image: UIImage, type: Type) {
    XCTContext.runActivity(named: type.named) { activity in
      let attachment = XCTAttachment(image: image)
      attachment.name = type.name
      activity.add(attachment)
    }
  }
}

fileprivate extension Type {
  var named: String {
    return "\(name) image)"
  }
  
  var name: String {
    switch self {
    case .reference:
      return "Reference"
    case .failed:
      return "Failed"
    case .diff:
      return "Diff"
    }
  }
}
