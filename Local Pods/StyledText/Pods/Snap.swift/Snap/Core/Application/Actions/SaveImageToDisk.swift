import UIKit

struct SaveImageToDisk {
  
  private let environment: Environment
  private let fileManager: FileManager
  
  init(environment: Environment,
       fileManager: FileManager)
  {
    self.environment = environment
    self.fileManager = fileManager
  }
  
  func execute(with image: UIImage, with reference: Reference) {
    let referenceImage = UIImagePNGRepresentation(image)
    
    do {
      try fileManager.createDirectory(atPath: reference.directory.path, withIntermediateDirectories: true)
    } catch {
      fatalError("🚨 Error creating reference image directory ['\(reference.directory)']")
    }
    guard fileManager.createFile(atPath: reference.path.path, contents: referenceImage) else {
      fatalError("🚨 Error saving reference image into ['\(reference.path)']")
    }
  }
}
