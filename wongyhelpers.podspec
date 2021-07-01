#
# Be sure to run `pod lib lint wongyhelpers.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'wongyhelpers'
  s.version          = '0.1.5'
  s.summary          = 'Some utilities to make the tedious stuff easier.'
  s.description      = <<-DESC
                        This pod adds simple, english functions out of the unintuitive parts of development
                       DESC
  s.homepage         = 'https://github.com/samuelwong1992/wongy-helpers'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'samuelwong1992' => 'samuelwong1992@gmail.com' }
  s.source           = { :git => 'https://github.com/samuelwong1992/wongy-helpers.git', :branch => "master", :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'wongyhelpers/Classes/**/*'
  
  s.swift_version = '5.0'
  
  # s.resource_bundles = {
  #   'wongyhelpers' => ['wongyhelpers/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
