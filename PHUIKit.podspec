#
# Be sure to run `pod lib lint PHUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PHUIKit'
  s.version          = '0.1.2'
  s.summary          = '自定义Kit'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
平常自定义的UIKit集合
                       DESC

  s.homepage         = 'https://github.com/xphaijj/PHUIKit.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'email' => '2112787533@qq.com' }
  s.source           = { :git => 'https://github.com/xphaijj/PHUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PHUIKit/Classes/**/*'

  s.dependency 'PHBaseLib'
  s.dependency 'PHModularLib'
  s.dependency 'Masonry'
  s.dependency 'ReactiveObjC'
  s.dependency 'DCURLRouter'
  s.dependency 'MJRefresh'
  

end
