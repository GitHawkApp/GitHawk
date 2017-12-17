import UIKit

protocol SnapshotLayerMatcherProvider {
  func makeMatcher(with layer: CALayer, isRecording: Bool, tesTarget: TestTarget) -> Matcher
}

struct SnapshotLayerMatcher: Matcher {
  
  private let layer: CALayer
  private let isRecording: Bool
  private let testTarget: TestTarget
  private let viewMatcherProvider: SnapshotViewMatcherProvider
  
  init(layer: CALayer,
       isRecording: Bool,
       testTarget: TestTarget,
       viewMatcherProvider: SnapshotViewMatcherProvider)
  {
    self.layer = layer
    self.isRecording = isRecording
    self.testTarget = testTarget
    self.viewMatcherProvider = viewMatcherProvider
  }
  
  func toMatchSnapshot() {
    toMatchSnapshot(named: nil)
  }
  
  func toMatchSnapshot(named: String?) {
    let view = UIView(frame: layer.frame)
    view.layer.insertSublayer(layer, at: 0)
    
    viewMatcherProvider.makeMatcher(
      with: view,
      isRecording: isRecording,
      tesTarget: testTarget
    ).toMatchSnapshot(named: named)
  }
}
