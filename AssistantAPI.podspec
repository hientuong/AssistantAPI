Pod::Spec.new do |s|
  s.name             = 'AssistantAPI'
  s.version          = '0.1.5'
  s.summary          = 'A short description of AssistantAPI.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/hientuong/AssistantAPI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hientuong' => 'hientuong.hust@gmail.com' }
  s.source           = { :git => 'https://github.com/hientuong/AssistantAPI.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.source_files = 'AssistantAPI/Classes/**/*'

  s.dependency 'Alamofire', '5.6.1'
  s.dependency 'RxSwift', '~> 6.5.0'
  s.dependency 'RxCocoa', '~> 6.5.0'
  s.dependency 'ObjectMapper', '~> 4.2.0'
end
