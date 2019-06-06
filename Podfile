# Uncomment the next line to define a global platform for your project

use_frameworks!
inhibit_all_warnings!

def session_pods
  pod 'GitHubAPI', :path => 'Local Pods/GitHubAPI'
  pod 'GitHubSession', :path => 'Local Pods/GitHubSession'
  pod 'DateAgo', :path => 'Local Pods/DateAgo'
  pod 'StringHelpers', :path => 'Local Pods/StringHelpers'
end

def testing_pods
  # normal pods
  pod 'AlamofireNetworkActivityIndicator', '~> 2.3'
  pod 'HTMLString', '~> 4.0'
  pod 'NYTPhotoViewer/AnimatedGifSupport', '~> 2.0.0'
  pod 'SDWebImage/GIF', '~> 4.0.0'
  pod 'SnapKit', '~> 4.2'
  pod 'TUSafariActivity', '~> 1.0'
  pod 'SwiftLint'
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'XLPagerTabStrip', '~> 8.1'
  pod 'ImageAlertAction'
  pod 'FMDB'

  # prerelease pods
  pod 'IGListKit/Swift', :git => 'https://github.com/GitHawkApp/IGListKit.git', :branch => 'fix-layout-insets'
  pod 'StyledTextKit', :git => 'https://github.com/GitHawkApp/StyledTextKit.git', :branch => 'master'
  pod 'Highlightr', :git => 'https://github.com/GitHawkApp/Highlightr.git', :branch => 'master'
  pod 'FlatCache', :git => 'https://github.com/GitHawkApp/FlatCache.git', :branch => 'master'
  pod 'MessageViewController', :git => 'https://github.com/GitHawkApp/MessageViewController.git', :branch => 'master'
  pod 'ContextMenu', :git => 'https://github.com/GitHawkApp/ContextMenu.git', :branch => 'master'
  pod 'cmark-gfm-swift', :git => 'https://github.com/GitHawkApp/cmark-gfm-swift.git', :branch => 'master'
  pod 'Squawk', :git => 'https://github.com/GitHawkApp/Squawk.git', :branch => 'master'
  pod 'GitHawkRoutes', :git => 'https://github.com/GitHawkApp/GitHawkRoutes.git', :branch => 'master'
  pod 'DropdownTitleView', :git => 'https://github.com/GitHawkApp/DropdownTitleView.git', :branch => 'master'

  # debugging pods
  pod 'FLEX', '~> 2.0', :configurations => ['Debug', 'TestFlight']

  # Local Pods w/ custom changes
  pod 'SwipeCellKit', :path => 'Local Pods/SwipeCellKit'
end

target 'Freetime' do

  platform :ios, '11.0'

  session_pods
  testing_pods

end

target 'FreetimeWatch' do
  platform :watchos, '3.0'
end

target 'FreetimeWatch Extension' do

  platform :watchos, '3.0'

  session_pods

end

target 'FreetimeTests' do
  
  platform :ios, '11.0'
  
  # normal pods
  pod 'FBSnapshotTestCase'

  session_pods
  testing_pods

end

post_install do |installer|
  system("sh tools/generateAcknowledgements.sh")
  
  installer.pods_project.targets.each do |target|  
    target.build_configurations.each do |config|  
        if config.build_settings['SDKROOT'] == 'watchos'  
          config.build_settings['WATCHOS_DEPLOYMENT_TARGET'] = '4.2'  
        end  
    end  
end  
end
