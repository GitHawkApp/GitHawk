Pod::Spec.new do |spec|
  spec.name         = 'StyledText'
  spec.version      = '0.1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/rnystrom/GitHawk'
  spec.authors      = { 'Ryan Nystrom' => 'rnystrom@whoisryannystrom.com' }
  spec.summary      = 'NSAttributedString building..'
  spec.source       = { :git => 'https://github.com/rnystrom/GitHawk.git', :tag => '#{s.version}' }
  spec.source_files = 'StyledText/*.swift'
  spec.platform     = :ios, '10.0'
end