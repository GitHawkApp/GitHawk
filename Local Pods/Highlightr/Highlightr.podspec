#
# Be sure to run `pod lib lint Highlightr.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Highlightr"
  s.version          = "1.1.0"
  s.summary          = "iOS & macOS Syntax Highlighter."

  s.description      = <<-DESC
                    Highlightr is an iOS & macOS syntax highlighter built with Swift. It uses highlight.js as it core, supports 166 languages and comes with 77 styles.
                       DESC

  s.homepage         = "http://github.com/raspu/Highlightr"
  s.screenshots     = "http://raw.githubusercontent.com/raspu/Highlightr/master/mix2.gif", "http://raw.githubusercontent.com/raspu/Highlightr/master/coding.gif"
  s.license          = 'MIT'
  s.author           = { "J.P. Illanes" => "jpillaness@gmail.com" }
  s.source           = { :git => "https://github.com/raspu/Highlightr.git", :tag => s.version.to_s, :submodules => true}

  s.osx.deployment_target = '10.11'
  s.ios.deployment_target = '8.0'

  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{swift}'

  s.resources  = 'Pod/Assets/**/*.{css,js}'

  s.ios.frameworks = 'UIKit'
  s.osx.frameworks = 'AppKit'
end





