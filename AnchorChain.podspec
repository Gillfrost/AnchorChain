Pod::Spec.new do |s|
  s.name             = 'AnchorChain'
  s.version          = '0.5.0'
  s.summary          = 'A fluent API for constraint-based iOS layout.'
  s.homepage         = 'https://github.com/gillfrost/AnchorChain'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'André Gillfrost' => '28143870+gillfrost@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/gillfrost/AnchorChain.git', :tag => s.version.to_s }
  s.swift_version    = '4.0'
  s.source_files = 'AnchorChain/Classes/**/*'
  s.ios.deployment_target = '11.0'
end
