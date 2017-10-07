# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

use_frameworks!
inhibit_all_warnings!

pod 'IGListKit', :git => 'https://github.com/Instagram/IGListKit.git', :branch => 'master'
pod 'SnapKit', '~> 4.0.0'
pod 'Alamofire', '~> 4.4.0'
pod 'AlamofireNetworkActivityIndicator', '~> 2.1'
pod 'SDWebImage', '~> 4.0.0'
pod 'JDStatusBarNotification', '~> 1.5.5'
pod 'Apollo', '~> 0.7.0-alpha.5'
pod 'TUSafariActivity', '~> 1.0.0'
pod 'NYTPhotoViewer', '~> 1.1.0'
pod 'FLEX', '~> 2.0', :configurations => ['Debug', 'TestFlight']
pod 'HTMLString', '~> 4.0.1'
pod 'Tabman', '~> 1.0'
pod 'SlackTextViewController', :path => 'Local Pods/SlackTextViewController'
pod 'SwipeCellKit', :path => 'Local Pods/SwipeCellKit'
pod 'MMMarkdown', :path => 'Local Pods/MMMarkdown'


target 'Freetime' do

end

target 'FreetimeTests' do

end

post_install do |installer|
  system("sh scripts/generateAcknowledgements.sh")

  # list all pods (local or remote) that need to be capped using swift 3.2
  swift_3_2_targets = ['SwipeCellKit']
  installer.pods_project.targets.each do |target|
    if swift_3_2_targets.include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.2'
      end
    end
  end

end
