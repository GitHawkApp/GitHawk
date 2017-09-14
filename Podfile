# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
project 'Freetime.xcodeproj'

use_frameworks!

pod 'IGListKit', :git => 'https://github.com/Instagram/IGListKit.git', :branch => 'master'
pod 'SnapKit', '~> 3.2.0'
pod 'Alamofire', '~> 4.4.0'
pod 'AlamofireNetworkActivityIndicator', '~> 2.1'
pod 'SDWebImage', '~> 4.0.0'
pod 'JDStatusBarNotification', '~> 1.5.5'
pod 'Apollo', '~> 0.5.6'
pod 'TUSafariActivity', '~> 1.0.0'
pod 'NYTPhotoViewer', '~> 1.1.0'
pod 'FLEX', '~> 2.0', :configurations => ['Debug']
pod 'HTMLString'

target 'Freetime' do
end

target 'FreetimeTests' do
end

post_install do |installer|
  system("sh scripts/generateAcknowledgements.sh")
end
