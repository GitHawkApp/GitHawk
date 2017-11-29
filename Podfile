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
pod 'Highlightr', '~> 1.1'

# prerelease pods
pod 'IGListKit', :git => 'https://github.com/Instagram/IGListKit.git', :branch => 'master'

# debugging pods
pod 'FLEX', '~> 2.0', :configurations => ['Debug', 'TestFlight']

# local pods w/ custom changes
pod 'MMMarkdown', :path => 'Local Pods/MMMarkdown'
pod 'SlackTextViewController', :path => 'Local Pods/SlackTextViewController'
pod 'SwipeCellKit', :path => 'Local Pods/SwipeCellKit'
pod 'FlatCache', :path => 'Local Pods/FlatCache'

target 'Freetime' do

end

target 'FreetimeTests' do
	pod 'FBSnapshotTestCase'
end

post_install do |installer|
  system("sh tools/generateAcknowledgements.sh")

  # convert incompatible pods back to Swift 3.2
  myTargets = ['Highlightr']  
  installer.pods_project.targets.each do |target|
    if myTargets.include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.2'
      end
    end
  end
end
