Pod::Spec.new do |s|
  s.name             = 'AssistantAPI'
  s.version          = '0.1.3'
  s.summary          = 'A short description of AssistantAPI.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/congnq/AssistantAPI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cong nguyen' => 'congnq.hp@gmail.com' }
  s.source           = { :git => 'git@github.com:congnq/AssistantAPI.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.source_files = 'AssistantAPI/Classes/**/*'

  s.dependency 'Alamofire', '5.6.1'
  s.dependency 'RxSwift', '~> 6.5.0'
  s.dependency 'RxCocoa', '~> 6.5.0'
end
