import UIKit

enum Type: String {
  case reference
  case failed
  case diff
}

extension TestTarget {
  func reference(for type: Type) -> Reference {
    // There should be a better way to handle with this ⚠️
    let classFile = file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? ""
    let functionName = function.replacingOccurrences(of: "()", with: "").lowercased()
    let path = "\(self.path(for: type))\(classFile)/"
    let directory = url.appendingPathComponent(path)
    let name = (named ?? functionName).replacingOccurrences(of: " ", with: "_")
    let pathUrl = directory.appendingPathComponent("\(type.rawValue)_\(name)\(scale).png")
    
    return Reference(
      directory: directory,
      path: pathUrl
    )
  }
  
  private var scale: String {
    let scale = Int(UIScreen.main.scale)
    guard scale == 1 else { return "@\(scale)x" }
    return ""
  }
  
  private var url: URL {
    guard let referenceImagePath = environment.get(Path.referenceImage) else {
      fatalError("🚧 You need to configure the reference image path environment variable `\(Path.referenceImage)`")
    }
    let fileURL = URL(fileURLWithPath: referenceImagePath)
    var isDir: ObjCBool = true
    let referenceImagePathExists = fileManager.fileExists(atPath: fileURL.path, isDirectory: &isDir)
    
    guard referenceImagePathExists else {
      fatalError("🚫 Provided path ['\(referenceImagePath)'] for `\(Path.referenceImage)` is invalid")
    }
    return fileURL
  }
  
  private func path(for type: Type) -> String {
    switch type {
    case .reference:
      return "Snap/"
    case .failed:
      return "Snap/Failed/"
    case .diff:
      return "Snap/Diff/"
    }
  }
}
