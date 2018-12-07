# JOCircularSlider

[![Version](https://img.shields.io/cocoapods/v/JOCircularSlider.svg?style=flat)](https://cocoapods.org/pods/JOCircularSlider)
[![License](https://img.shields.io/cocoapods/l/JOCircularSlider.svg?style=flat)](https://cocoapods.org/pods/JOCircularSlider)
[![Platform](https://img.shields.io/cocoapods/p/JOCircularSlider.svg?style=flat)](https://cocoapods.org/pods/JOCircularSlider)
[![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)]()
[![Twitter: @ouraigua](https://img.shields.io/badge/contact-@ouraigua-blue.svg?style=flat)](https://twitter.com/ouraigua)
[![Readme Score](http://readme-score-api.herokuapp.com/score.svg?url=https://github.com/ouraigua/jocircularslider)](http://clayallsopp.github.io/readme-score?url=https://github.com/ouraigua/jocircularslider)
[![codebeat badge](https://codebeat.co/badges/c4db03f5-903a-4b0e-84bb-98362fc5bd7a)](https://codebeat.co/projects/github-com-ouraigua-jocircularslider-master)

## Overview

JOCircularSlider is a highly customisable and reusable circular slider for iOS applications.
The knob control uses no preset images and every one of its elements is drawn completely in code making very adaptable to every design and theme.  


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![](https://github.com/ouraigua/JOCircularSlider/blob/master/Screenshots/shot1.gif) 
![](https://github.com/ouraigua/JOCircularSlider/blob/master/Screenshots/shot2.gif) 
![](https://github.com/ouraigua/JOCircularSlider/blob/master/Screenshots/shot3.gif)

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

```swift
import JOCircularSlider
```
Drag a UIView to your storyboard, change its class of to CircularSlider and start visually customising the design to your liking.
All the paramters are IBInspectable, so you can configure the slider straight from the attribute inspector tab, without having to write a single line of code.

![](https://github.com/ouraigua/JOCircularSlider/blob/master/Screenshots/shot4.gif)

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

## References

The project is Inspired by:
- [How To Make a Custom Control Tutorial: A Reusable Knob](https://www.raywenderlich.com/5294-how-to-make-a-custom-control-tutorial-a-reusable-knob)
- [HGCircularSlider](https://github.com/HamzaGhazouani/HGCircularSlider)

## Author

Jalal Ouraigua, ouraigua@icloud.com

## License

JOCircularSlider is available under the MIT license. See the LICENSE file for more info.
