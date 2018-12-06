//
//  Utils.swift
//  JOCircularSlider_Example
//
//  Created by Jalal Ouraigua on 06/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import JOCircularSlider

@IBDesignable
class DesignableSlider: UISlider {

    @IBInspectable
    var thumbImage: UIImage {
        get { return currentThumbImage ?? UIImage()}
        set { setThumbImage(newValue, for: .normal)}
    }
}

enum Theme: Int {

    case dark
    case light

    var gradientViewColor1: UIColor {
        switch self {
        case .light: return UIColor(red: 239/255.0, green: 239/255.0, blue: 240/255.0, alpha: 1)
        case .dark: return UIColor(red: 28/255.0, green: 33/255.0, blue: 40/255.0, alpha: 1)
        }
    }

    var gradientViewColor2: UIColor {
        switch self {
        case .light: return UIColor(red: 212/255.0, green: 216/255.0, blue: 221/255.0, alpha: 1)
        case .dark: return UIColor(red: 34/255.0, green: 36/255.0, blue: 42/255.0, alpha: 1)
        }
    }

    var onColor: UIColor {
        return self == .light ? Constants.dotBlueColor : Constants.dotOrangeColor
    }
    var color1: UIColor {
        return self == .light ? Constants.lightColor1 : Constants.darkColor1
    }
    var color2: UIColor {
        return self == .light ? Constants.lightColor2 : Constants.darkColor2
    }
    var color3: UIColor {
        return self == .light ? Constants.lightColor3 : Constants.darkColor3
    }
    var color4: UIColor {
        return self == .light ? Constants.lightColor4 : Constants.darkColor4
    }
    var highlightColor: UIColor {
        return self == .light ? Constants.lightHighlightColor : Constants.darkHighlightColor
    }
    var textColor: UIColor {
        return self == .light ? Constants.lightTextColor : Constants.darkTextColor
    }
    var maxidotOffColor: UIColor {
        return self == .light ? Constants.dotGrayColor : .black
    }
    var pointerColor1: UIColor {
        return self == .light ? Constants.lightColor4 : .black
    }
    var pointerColor2: UIColor {
        return self == .light ? .white : UIColor(red: 65/255.0, green: 69/255.0, blue: 81/255.0, alpha: 1.0)
    }
    var shadowOpacity: Float {
        return self == .light ? 0.4 : 0.8
    }

    var minidotColor: UIColor {
        return self == .light ? Constants.dotGrayColor : .black
    }

    var minidotHighlightColor: UIColor {
        return self == .light ? Constants.lightHighlightColor : Constants.darkHighlightColor
    }
}

enum Direction: Int {
    case antiClockwise
    case clockwise

    var startAngle: CGFloat {
        return self == .antiClockwise ? 230.0 : 140.0
    }
    var endAngle: CGFloat {
        return self == .antiClockwise ? 310.0 : 40.0
    }

}



