@version = "0.5.5"

Pod::Spec.new do |s|
  s.name         		= "MMMarkdown"
  s.version      		= @version
  s.summary      		= "An Objective-C static library for converting Markdown to HTML."
  s.homepage        = "https://github.com/mdiep/MMMarkdown"
  s.license         = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author       		= { "Matt Diephouse" => "matt@diephouse.com" }
  s.source          = { :git => "https://github.com/mdiep/MMMarkdown.git", :tag => "#{s.version}" }

  s.platform     		= :ios, "8.0"
  s.requires_arc 		= true

  s.source_files 		= 'Source/**/*.{h,m}'
end
