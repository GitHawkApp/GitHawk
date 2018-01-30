# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

use_frameworks!
inhibit_all_warnings!

# normal pods
pod 'Alamofire', '~> 4.4.0'
pod 'AlamofireNetworkActivityIndicator', '~> 2.1'
pod 'Apollo', '~> 0.7.0-alpha.5'
pod 'HTMLString', '~> 4.0.1'
pod 'NYTPhotoViewer', '~> 1.1.0'
pod 'SDWebImage/GIF', '~> 4.0.0'
pod 'SnapKit', '~> 4.0.0'
pod 'TUSafariActivity', '~> 1.0.0'
pod 'SwiftLint'
pod 'Fabric'
pod 'Crashlytics'
pod 'Tabman', '~> 1.1'
pod 'Firebase/Core'
pod 'Firebase/Database' 

# prerelease pods
pod 'IGListKit', :git => 'https://github.com/Instagram/IGListKit.git', :branch => 'master'
pod 'StyledText', :git => 'https://github.com/GitHawkApp/StyledText.git', :branch => 'master'
pod 'Highlightr', :git => 'https://github.com/GitHawkApp/Highlightr.git', :branch => 'master'
pod 'MMMarkdown', :git => 'https://github.com/GitHawkApp/MMMarkdown.git', :branch => 'master'
pod 'FlatCache', :git => 'https://github.com/GitHawkApp/FlatCache.git', :branch => 'master'
pod 'MessageViewController', :git => 'https://github.com/GitHawkApp/MessageViewController.git', :branch => 'master'

# debugging pods
pod 'FLEX', '~> 2.0', :configurations => ['Debug', 'TestFlight']

# Local Pods w/ custom changes
pod 'SwipeCellKit', :path => 'Local Pods/SwipeCellKit'

target 'Freetime' do

end

target 'FreetimeTests' do
	pod 'FBSnapshotTestCase'
end

post_install do |installer|
  system("sh tools/generateAcknowledgements.sh")
end
