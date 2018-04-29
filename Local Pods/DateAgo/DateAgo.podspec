Pod::Spec.new do |spec|
  spec.name         = 'DateAgo'
  spec.version      = '0.1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/GitHawkApp/githawk'
  spec.authors      = { 'Ryan Nystrom' => 'rnystrom@whoisryannystrom.com' }
  spec.summary      = '.'
  spec.source       = { :git => 'https://github.com/GitHawkApp/githawk/githawk.git', :tag => '#{s.version}' }
  spec.source_files = 'DateAgo/*.swift'
  spec.resource_bundle = { "Resources" => ["DateAgo/Localizable.stringsdict"] }
  spec.ios.deployment_target     = '11.0'
  spec.watchos.deployment_target = '3.0'
end
