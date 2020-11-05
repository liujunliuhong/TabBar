
Pod::Spec.new do |s|
  s.name             = 'GLTabBar'
  s.version          = '1.0.2'
  s.summary          = '一个高度自定义的TabBarController组件，继承自UITabBarController'
  s.description      = '一个高度自定义的TabBarController组件，继承自UITabBarController..'
  s.homepage         = 'https://github.com/liujunliuhong/TabBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liujunliuhong' => '1035841713@qq.com' }
  s.source           = { :git => 'https://github.com/liujunliuhong/TabBar.git', :tag => s.version.to_s }

  s.module_name = 'GLTabBar'
  s.swift_version = '5.0'
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.source_files = 'Sources/*.swift'
end
