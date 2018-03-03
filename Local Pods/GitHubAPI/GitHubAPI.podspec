Pod::Spec.new do |spec|
  spec.name         = 'GitHubAPI'
  spec.version      = '0.1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/rnystrom/githawk'
  spec.authors      = { 'Ryan Nystrom' => 'rnystrom@whoisryannystrom.com' }
  spec.summary      = '.'
  #spec.source       = { :git => 'https://github.com/GitHawkApp/StyledText/StyledText.git', :tag => '#{s.version}' }
  spec.source_files = 'GitHubAPI/*.swift'
  spec.platform     = :ios, '11.0'
end
