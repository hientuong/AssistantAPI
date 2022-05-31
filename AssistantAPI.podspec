Pod::Spec.new do |s|
  s.name             = 'AssistantAPI'
  s.version          = '0.1.0'
  s.summary          = 'A short description of AssistantAPI.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/congnq/AssistantAPI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cong nguyen' => 'congnq.hp@gmail.com' }
  s.source           = { :git => 'git@github.com:congnq/AssistantAPI.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'

  s.source_files = 'AssistantAPI/Classes/**/*'
  
end
