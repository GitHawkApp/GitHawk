import UIKit
import XCTest

struct ExtractViewImage {
  
  private let saveImageToDisk: SaveImageToDisk
  private let addAttachment: AddAttachment
  
  init(saveImageToDisk: SaveImageToDisk,
       addAttachment: AddAttachment)
  {
    self.saveImageToDisk = saveImageToDisk
    self.addAttachment = addAttachment
  }
  
  func execute(with view: UIView, testTarget: TestTarget) {
    guard let image = view.render() else {
      fatalError("🖼 Can not extract image from view")
    }
    saveImageToDisk.execute(with: image, with: testTarget.reference(for: .reference))
    addAttachment.execute(with: image, type: .reference)
    
    XCTFail("⚠️ Test ran in record mode, reference image has been saved to \(testTarget.reference(for: .reference).path.path), now remove `isRecording` in order to perform the snapshot comparsion.")
  }
}
