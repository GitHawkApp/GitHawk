Pod::Spec.new do |spec|
  spec.name         = 'MessageViewController'
  spec.version      = '0.1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/rnystrom/GitHawk'
  spec.authors      = { 'Ryan Nystrom' => 'rnystrom@whoisryannystrom.com' }
  spec.summary      = 'Replacement for SlackTextViewController.'
  spec.source       = { :git => 'https://github.com/rnystrom/GitHawk.git', :tag => '#{s.version}' }
  spec.source_files = 'MessageViewController/*.swift'
  spec.platform     = :ios, '10.0'
end