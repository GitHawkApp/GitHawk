import UIKit
import XCTest

// MARK: - XCTestCase + CALayer Expectation

extension XCTestCase {
  public func expect(_ layer: CALayer, function: String = #function, file: String = #file ) -> Matcher {
    let testTarget = TestTarget(
      function: function,
      file: file
    )
    return resolver.makeMatcher(
      with: layer,
      isRecording: isRecording,
      tesTarget: testTarget
    )
  }
}
