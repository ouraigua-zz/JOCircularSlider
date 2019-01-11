#
# Be sure to run `pod lib lint JOCircularSlider.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'JOCircularSlider'
    s.version          = '2.0.3'
    s.summary          = 'A highly customisable and reusable iOS circular slider.'

    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
    JOCircularSlider is a highly customisable and reusable iOS circular slider that mimics the behaviour of a knob control. It uses no preset images and every one of its components is drawn completely in code making it extremely adaptable to every design and theme.
    It's written in Swift 4.2 and it's 100% IBDesignable and all parameters are IBInspectable.
    You can control almost every aspect of the slider's design: Size, colors, direction (clockwise/anti-clockwise), etc...
    DESC

    s.homepage         = 'https://github.com/ouraigua/JOCircularSlider'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Jalal Ouraigua' => 'ouraigua@icloud.com' }
    s.source           = { :git => 'https://github.com/ouraigua/JOCircularSlider.git', :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/ouraigua'

    s.ios.deployment_target = '10.0'

    s.source_files = 'JOCircularSlider/Classes/**/*'

    s.documentation_url = 'http://ouraigua.com/github/jocircularslider/docs/index.html'
  
    # s.resource_bundles = {
    #   'JOCircularSlider' => ['JOCircularSlider/Assets/*.png']
    # }

    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
end
