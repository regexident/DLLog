Pod::Spec.new do |s|

  s.name         = "DLLog"
  s.version      = "1.0.2"
  s.summary      = "NSLog-like logging API with support for level and context filtering."

  s.description  = <<-DESC
				   **DLLog** aims to provide an NSLog-like logging API with support for (compile-time, as well as optional run-time) level and (optional run-time only) context filtering.
                   DESC

  s.homepage     = "https://github.com/regexident/DLLog"
  s.license      = { :type => 'BSD-3', :file => 'LICENSE' }
  s.author       = { "Vincent Esche" => "regexident@gmail.com" }
  s.source       = { :git => "https://github.com/regexident/DLLog.git", :tag => '1.0.2' }
  s.source_files  = 'DLLog/Classes/*.{h,m}'
  s.requires_arc = true
  s.ios.deployment_target = "4.0"
  s.osx.deployment_target = "10.6"

end
