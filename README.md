# JOCircularSlider

[![Version](https://img.shields.io/cocoapods/v/JOCircularSlider.svg?style=flat)](https://cocoapods.org/pods/JOCircularSlider)
[![License](https://img.shields.io/cocoapods/l/JOCircularSlider.svg?style=flat)](https://cocoapods.org/pods/JOCircularSlider)
[![Platform](https://img.shields.io/cocoapods/p/JOCircularSlider.svg?style=flat)](https://cocoapods.org/pods/JOCircularSlider)

## Overview

JOCircularSlider is a highly customaizable and reusable circular slider for iOS applications.


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![](/Screenshots/shot1.gif)![](/Screenshots/shot2.gif)

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

## Author

Jalal Ouraigua, ouraigua@icloud.com

## License

JOCircularSlider is available under the MIT license. See the LICENSE file for more info.
