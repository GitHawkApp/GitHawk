import UIKit
import XCTest

public extension XCTestCase {
  @objc
  public func verify(view: UIView, function: String = #function, file: String = #file) {
    let testTarget = TestTarget(
      function: function,
      file: file
    )
    return resolver.makeMatcher(
      with: view,
      isRecording: isRecording,
      tesTarget: testTarget
    ).toMatchSnapshot()
  }

  @objc
  public func verify(layer: CALayer, function: String = #function, file: String = #file) {
    let testTarget = TestTarget(
      function: function,
      file: file
    )
    return resolver.makeMatcher(
      with: layer,
      isRecording: isRecording,
      tesTarget: testTarget
    ).toMatchSnapshot()
  }
}
