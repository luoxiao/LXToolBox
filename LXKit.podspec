Pod::Spec.new do |s|
  s.name = 'ToolCar'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'Elegant HTTP Networking in Swift'
  s.homepage = 'https://github.com/luoxiao/ToolCar'
  s.authors = { 'Alamofire Software Foundation' => 'info@alamofire.org' }
  s.source = { :git => 'https://github.com/luoxiao/ToolCar.git', :tag => s.version }
  s.documentation_url = 'https://github.com/luoxiao/ToolCar'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

  s.swift_versions = ['5.0', '5.1']

  s.source_files = 'Extension/*.swift'

  s.frameworks = 'CFNetwork'
end
