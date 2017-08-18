Pod::Spec.new do |s|
  s.name         = "CNLFoundationTools"
  s.version      = "0.0.17"
  s.summary      = "Common extensions to Foundation."
  s.description  = <<-DESC
Common extensions to Foundation.
Commonly used in other Complex Numbers projects.
                   DESC
  s.homepage     = "https://github.com/megavolt605/CNLFoundationTools"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Igor Smirnov" => "megavolt605@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/megavolt605/CNLFoundationTools.git", :tag => "#{s.version}" }
  s.source_files  = "CNLFoundationTools/**/*.{h,m,swift}"
  s.framework  = "Foundation", "CoreLocation"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
end
