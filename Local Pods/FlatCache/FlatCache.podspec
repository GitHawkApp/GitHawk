Pod::Spec.new do |spec|
  spec.name         = 'FlatCache'
  spec.version      = '0.1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/rnystrom/GitHawk'
  spec.authors      = { 'Ryan Nystrom' => 'rnystrom@whoisryannystrom.com' }
  spec.summary      = 'In memory flat cache.'
  spec.source       = { :git => 'https://github.com/rnystrom/GitHawk.git', :tag => '#{s.version}' }
  spec.source_files = 'FlatCache/*.swift'
end