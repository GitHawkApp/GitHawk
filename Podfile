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
pod 'Tabman', '1.0.1'
pod 'TUSafariActivity', '~> 1.0.0'

# not using the original git repository as that one doesn't compile in Swift 4 out of the box
pod 'Highlightr', :git => 'https://github.com/macteo/Highlightr.git', :branch => 'swift4'

# prerelease pods
pod 'IGListKit', :git => 'https://github.com/Instagram/IGListKit.git', :branch => 'master'

# debugging pods
pod 'FLEX', '~> 2.0', :configurations => ['Debug', 'TestFlight']

# local pods w/ custom changes
pod 'MMMarkdown', :path => 'Local Pods/MMMarkdown'
pod 'SlackTextViewController', :path => 'Local Pods/SlackTextViewController'
pod 'SwipeCellKit', :path => 'Local Pods/SwipeCellKit'

target 'Freetime' do

end

target 'FreetimeTests' do

end

post_install do |installer|
  system("sh tools/generateAcknowledgements.sh")
end
