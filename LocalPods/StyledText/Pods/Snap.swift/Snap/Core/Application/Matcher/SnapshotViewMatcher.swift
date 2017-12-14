import UIKit

protocol SnapshotViewMatcherProvider {
  func makeMatcher(with view: UIView, isRecording: Bool, tesTarget: TestTarget) -> Matcher
}

struct SnapshotViewMatcher: Matcher {
  
  private let view: UIView
  private let isRecording: Bool
  private let testTarget: TestTarget
  private let extractViewImage: ExtractViewImage
  private let compareImages: CompareImages
  
  init(view: UIView,
       isRecording: Bool = false,
       testTarget: TestTarget,
       extractViewImage: ExtractViewImage,
       compareImages: CompareImages)
  {
    self.view = view
    self.isRecording = isRecording
    self.testTarget = testTarget
    self.extractViewImage = extractViewImage
    self.compareImages = compareImages
  }
  
  func toMatchSnapshot() {
    guard isRecording else {
      compareImages.compare(with: view, testTarget: testTarget)
      return
    }
    extractViewImage.execute(with: view, testTarget: testTarget)
  }
}
