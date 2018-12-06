//
//  GradientView.swift
//  JOCircularSlider_Example
//
//  Created by Jalal Ouraigua on 05/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable
    var color1: UIColor = .red { didSet { setNeedsDisplay() }}

    @IBInspectable
    var color2: UIColor = .blue { didSet { setNeedsDisplay() }}

    override func draw(_ rect: CGRect) {

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let cgColors = [color1.cgColor, color2.cgColor]
        let locations: [CGFloat] = [0.0, 1.0]

        let context = UIGraphicsGetCurrentContext()!

        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors  as CFArray, locations: locations) else { return }


        context.drawLinearGradient(gradient, start: .zero, end: CGPoint(x: 0, y: bounds.height), options: CGGradientDrawingOptions(rawValue: 0))
    }
}
