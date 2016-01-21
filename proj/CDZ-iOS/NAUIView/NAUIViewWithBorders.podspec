Pod::Spec.new do |s|

  s.name         = "NAUIViewWithBorders"
  s.version      = "0.1.0"
  s.summary      = "UIView subclass that enables selective borders.  Each side can be figured with a different color and width or not exist at all."

  s.description  = <<-DESC
                   UIView subclass that enables selective borders.
		   Each side can be figured with a different color and width or not exist at all.
                   DESC

  s.homepage     = "https://github.com/natrosoft/NAUIViewWithBorders"
  s.screenshots  = "http://natrosoft.com/wp-content/uploads/2014/01/oneBorder.png", "http://natrosoft.com/wp-content/uploads/2014/01/differentBorders.png", "http://natrosoft.com/wp-content/uploads/2014/01/selectiveBorderSS.jpg"

  s.license          = 'MIT'
  s.author           = { "Nathan Rowe" => "natrosoft@gmail.com" }
  s.source           = { :git => "https://github.com/natrosoft/NAUIViewWithBorders.git", :tag => s.version.to_s }

  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.requires_arc = true

  s.source_files = 'Classes/**/*.{h,m}'
  s.public_header_files = 'Classes/**/*.h'
  s.exclude_files = "Classes/Exclude"

end
