import UIKit

// MARK: - SnapshotViewMatcherProvider

extension Assembly: SnapshotViewMatcherProvider {
  func makeMatcher(with view: UIView, isRecording: Bool, tesTarget: TestTarget) -> Matcher {
    return SnapshotViewMatcher(
      view: view,
      isRecording: isRecording,
      testTarget: tesTarget,
      extractViewImage: extractViewImage,
      compareImages: compareImages
    )
  }
}

// MARK: - SnapshotLayerMatcherProvider

extension Assembly: SnapshotLayerMatcherProvider {
  func makeMatcher(with layer: CALayer, isRecording: Bool, tesTarget: TestTarget) -> Matcher {
    return SnapshotLayerMatcher(
      layer: layer,
      isRecording: isRecording,
      testTarget: tesTarget,
      viewMatcherProvider: self
    )
  }
}
