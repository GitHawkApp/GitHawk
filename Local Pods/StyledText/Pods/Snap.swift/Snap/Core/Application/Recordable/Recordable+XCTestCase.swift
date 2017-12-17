import XCTest
import ObjectiveC

private var recordingPointer: UInt8 = 0

extension XCTestCase: Recordable {
  public var isRecording: Bool {
    get {
      return (objc_getAssociatedObject(self, &recordingPointer) as? Bool) ?? false
    }
    set {
      objc_setAssociatedObject(self, &recordingPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
}
