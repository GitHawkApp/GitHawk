import UIKit

struct TestTarget {
  
  let function: String
  let file: String
  let named: String?
  let fileManager: FileManager
  let environment: Environment
  
  init(function: String,
       file: String,
       named: String? = nil,
       fileManager: FileManager = resolver.fileManager,
       environment: Environment = resolver.environment)
  {
    self.function = function
    self.file = file
    self.named = named
    self.fileManager = fileManager
    self.environment = environment
  }
}

extension TestTarget {
  func named(_ named: String?) -> TestTarget {
    return TestTarget(function: function, file: file, named: named)
  }
}
