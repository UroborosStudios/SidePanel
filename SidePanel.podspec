#
#  Be sure to run `pod spec lint SidePanel.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "SidePanel"
  s.version      = "0.0.1"
  s.summary      = "Creating left and right menus was never so easy"

  s.description  = "With this framework, you can easily add left or right menu controllers on you application."

  s.homepage     = "https://github.com/UroborosStudios/SidePanel"

  s.license      = "MIT"

  s.author       = { "Jonathan Silva" => "jhi.290292@gmail.com" }
  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/UroborosStudios/SidePanel", :tag => "1.0.0" }

  s.source_files  = "**/*.{h,m,swift}"
  s.exclude_files = "**/USTableViewTests.swift"

  #s.resources = "**/*.mp3"

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }

end