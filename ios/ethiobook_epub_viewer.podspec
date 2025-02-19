#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'ethiobook_epub_viewer'
  s.version          = '2.0.0'
  s.summary          = 'A ethiobook epub reader flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://github.com/samkiyya/custom_epub_viewer.git'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'samkiyya' => 'samuelkiyya2012@gmail.com' }
  s.source           = { :path => '.' }
  
  
  s.source_files = [
  'Classes/**/*',
  ]

  s.dependency 'Flutter'
  
  s.dependency 'EpubViewerKit', '~> 0.1.3'
  s.ios.deployment_target = '9.0'

  
end
