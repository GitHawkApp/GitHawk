import UIKit

enum Type: String {
  case reference
  case failed
  case diff
}

struct TestTarget {
  let function: String
  let file: String
  let fileManager: FileManager = resolver.fileManager
  let environment: Environment = resolver.environment
}

extension TestTarget {
  func reference(for type: Type) -> Reference {
    // There should be a better way to handle with this ⚠️
    let classFile = file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? ""
    let functionName = function.replacingOccurrences(of: "()", with: "").lowercased()
    let path = "\(self.path(for: type))\(classFile)/"
    let directory = url.appendingPathComponent(path)
    let pathUrl = directory.appendingPathComponent("\(type.rawValue)_\(functionName)\(scale).png")
    
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
    
    var isDir: ObjCBool = true
    let referenceImagePathExists = fileManager.fileExists(atPath: referenceImagePath, isDirectory: &isDir)
    
    guard referenceImagePathExists, let url = URL(string: referenceImagePath) else {
      fatalError("🚫 Provided path ['\(referenceImagePath)'] for `\(Path.referenceImage)` is invalid")
    }
    return url
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
