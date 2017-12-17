import UIKit
import XCTest

struct CompareImages {
  
  private let fileManager: FileManager
  private let addAttachment: AddAttachment
  private let saveImageToDisk: SaveImageToDisk
  
  init(fileManager: FileManager,
       addAttachment: AddAttachment,
       saveImageToDisk: SaveImageToDisk)
  {
    self.fileManager = fileManager
    self.addAttachment = addAttachment
    self.saveImageToDisk = saveImageToDisk
  }
  
  func compare(with view: UIView, testTarget: TestTarget) {
    guard let image = view.render() else {
      fatalError("🖼 Can not extract image from view")
    }
    
    let reference = testTarget.reference(for: .reference).path
    guard fileManager.fileExists(atPath: reference.path) else {
      XCTFail("🚫 Reference image not found [`\(reference.path)`]")
      return
    }
    
    guard let referenceImage = UIImage(contentsOfFile: reference.path) else {
      XCTFail("🚫 Error loading reference image [`\(reference.path)`]")
      return
    }
    
    guard let pngImage = UIImagePNGRepresentation(image), let processedImage = UIImage(data: pngImage) else {
      XCTFail("🚫 Cannot process view image")
      return
    }
    
    addAttachment.execute(with: referenceImage, type: .reference)
    
    do {
      try referenceImage.compare(with: processedImage)
    } catch CompareError.notEqualSize(let referenceSize, let comparedSize) {
      self.process(failedImage: processedImage, reference: referenceImage, testTarget: testTarget)
      XCTFail("📏 Image sizes should be equals, reference image size: \(referenceSize), compared image size: \(comparedSize)")
    } catch CompareError.invalidImageSize {
      self.process(failedImage: processedImage, reference: referenceImage, testTarget: testTarget)
      XCTFail("📏 One of the images has 0 size")
    } catch CompareError.notEquals {
      self.process(failedImage: processedImage, reference: referenceImage, testTarget: testTarget)
      XCTFail("≠ Images are not equal")
    } catch CompareError.notEqualMetadata {
      self.process(failedImage: processedImage, reference: referenceImage, testTarget: testTarget)
      XCTFail("👾 Images have different metadata information")
    } catch CompareError.invalidReferenceImage {
      self.process(failedImage: processedImage, reference: referenceImage, testTarget: testTarget)
      XCTFail("👾 Invalid reference image")
    } catch {
      self.process(failedImage: processedImage, reference: referenceImage, testTarget: testTarget)
      XCTFail("🚫 Unknown error")
    }
  }
  
  private func process(failedImage: UIImage, reference: UIImage, testTarget: TestTarget) {
    addAttachment.execute(with: failedImage, type: .failed)
    saveImageToDisk.execute(with: failedImage, with: testTarget.reference(for: .failed))
    
    guard let diffedImage = reference.diff(with: failedImage) else { return }
    addAttachment.execute(with: diffedImage, type: .diff)
    saveImageToDisk.execute(with: diffedImage, with: testTarget.reference(for: .diff))
  }
}
