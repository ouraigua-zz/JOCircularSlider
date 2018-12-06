//
//  PointerView.swift
//  JOCircularSlider
//
//  Created by Jalal Ouraigua on 04/12/2018.
//  Copyright © 2018 Jalal Ouraigua. All rights reserved.
//

import UIKit

class PointerView: UIView {

    // MARK: Public Properties

    var color1: UIColor = Constants.lightColor4 {
        didSet { setNeedsDisplay() }
    }

    var color2: UIColor = .white {
        didSet { setNeedsDisplay() }
    }


    // MARK: - Private Properties

    private var cgColors: [CGColor] { return [color1.cgColor, color2.cgColor] }

    // MARK: -

    override func draw(_ rect: CGRect) {

        let path = UIBezierPath(ovalIn: rect)
        path.addClip()

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: [0, 1]) else { return }

        let context = UIGraphicsGetCurrentContext()!
        context.drawLinearGradient(gradient, start: .zero, end: CGPoint(x: 0, y: rect.height), options: [])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
    }

}
