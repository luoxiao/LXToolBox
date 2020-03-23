Pod::Spec.new do |s|
  s.name = 'LXToolBox'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'LUO XIAO ToolBox'
  s.homepage = 'https://github.com/luoxiao/LXKit'
  s.authors = { 'LUO XIAO' => 'luoxiao1115@163.com' }
  s.source = { :git => 'https://github.com/luoxiao/LXKit.git', :tag => s.version }
  s.documentation_url = 'https://github.com/luoxiao/LXKit'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

  s.swift_versions = ['5.0', '5.1']

  s.source_files = 'Utilities/*/*/*.swift'

  s.frameworks = 'CFNetwork'
  
  s.dependency 'SnapKit'
  s.dependency 'Kingfisher'
  s.dependency 'DateToolsSwift'
  
end
