Pod::Spec.new do |s|
  s.name             = 'AnchorWhat'
  s.version          = '0.1.0'
  s.summary          = 'A uniform and intuitive API for Autolayout constraints.'
  s.homepage         = 'https://github.com/gillfrost/AnchorWhat'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'André Gillfrost' => '28143870+gillfrost@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/gillfrost/AnchorWhat.git', :tag => s.version.to_s }
  s.swift_version    = '4.0'
  s.source_files = 'AnchorWhat/Classes/**/*'
  s.ios.deployment_target = '11.0'
end
