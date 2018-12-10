![](https://raw.githubusercontent.com/ouraigua/JOCircularSlider/master/Screenshots/banner.gif) 

[![Version](https://img.shields.io/cocoapods/v/JOCircularSlider.svg?style=flat)](https://cocoapods.org/pods/JOCircularSlider)
[![Platform](https://img.shields.io/cocoapods/p/JOCircularSlider.svg?style=flat)](https://cocoapods.org/pods/JOCircularSlider)
[![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)]()
[![License](https://img.shields.io/cocoapods/l/JOCircularSlider.svg?style=flat)](https://cocoapods.org/pods/JOCircularSlider)
[![Twitter: @ouraigua](https://img.shields.io/badge/twitter-@ouraigua-blue.svg?style=flat)](https://twitter.com/ouraigua)
[![Readme Score](http://readme-score-api.herokuapp.com/score.svg?url=https://github.com/ouraigua/jocircularslider)](http://clayallsopp.github.io/readme-score?url=https://github.com/ouraigua/jocircularslider)
[![codebeat badge](https://codebeat.co/badges/c4db03f5-903a-4b0e-84bb-98362fc5bd7a)](https://codebeat.co/projects/github-com-ouraigua-jocircularslider-master)

# JOCircularSlider

JOCircularSlider is a highly customisable and reusable iOS circular slider that mimics the behaviour of a knob control.
It uses no preset images and every one of its components is drawn completely in code making it extremely adaptable to every design and theme.  

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![](https://raw.githubusercontent.com/ouraigua/JOCircularSlider/master/Screenshots/shot1.gif) 
![](https://raw.githubusercontent.com/ouraigua/JOCircularSlider/master/Screenshots/shot2.gif) 
![](https://raw.githubusercontent.com/ouraigua/JOCircularSlider/master/Screenshots/shot3.gif)

## Requirements

- iOS 10.0+
- Xcode 10.0

## Installation

JOCircularSlider is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JOCircularSlider'
```

## Usage
1. Visually:

Drag a UIView to your storyboard, change its class of to CircularSlider and start visually customising the design to your liking.
All the parameters are IBInspectable, so you can configure the slider straight from the attribute inspector tab, without having to write a single line of code.

![](https://raw.githubusercontent.com/ouraigua/JOCircularSlider/master/Screenshots/shot4.gif)

2. Programatically:

```swift
import JOCircularSlider

let circularSlider = CircularSlider(frame: aFrame)
circularSlider.startAngle = 230
circularSlider.endAngle = 310
circularSlider.minimumValue = 0
circularSlider.maximumValue = 60
circularSlider.isClockwise = false
```
These are just few of the many params you can configure for the slider.

The slider's `value` property is read-only.
```swift
/**
    returns a value in the range 0.0 (minimumValue) to 1.0 (maximumValue). 
    The default value of this property is 0.0. 
*/
open private (set) var value: Float = 0
```

To set the slider's value use the following:
```swift
/**
    Set the `value`.
    - parameter newValue:      if `isPercentage` then new value must be in the range 0.0 to 1.0
    - parameter isPercentage:  specifies if newValue is in the range [0.0, 1.0] or not
*/
open func setValue(_ newValue: Float, isPercentage: Bool = false)
```

In order to get value change notifications, use the `Target-Action` pattern which is an inherent part of UIControl, like so:
``` swift
circularSlider.addTarget(target: Any?, action: Selector, for: UIControl.valueChanged)
```

To Control the text's appearance, use these:
```swift
open func setTextFont(named: String, textColor: UIColor, multiplier: CGFloat)
open func setTextShadow(color: UIColor, opacity: Float = 1, offset: CGSize = CGSize(width: 1, height: 1), radius: CGFloat = 0)
```

## References

The project is Inspired by:
- [How To Make a Custom Control Tutorial: A Reusable Knob](https://www.raywenderlich.com/5294-how-to-make-a-custom-control-tutorial-a-reusable-knob)
- [HGCircularSlider](https://github.com/HamzaGhazouani/HGCircularSlider)

## Author

Jalal Ouraigua, ouraigua@icloud.com

## License

JOCircularSlider is available under the MIT license. See the LICENSE file for more info.
