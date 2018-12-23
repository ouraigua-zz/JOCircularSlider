//
//  KnobView.swift
//  JOCircularSlider
//
//  Created by Jalal Ouraigua on 04/12/2018.
//  Copyright © 2018 Jalal Ouraigua. All rights reserved.
//

import UIKit

class KnobView: UIView {

    // MARK: - Public Properties

    var color1: UIColor = Constants.lightColor1 {
        didSet {
            outerCircleStroke.colors[0] = color1
            outerCircle.colors[0] = color1
        }
    }
    var color2: UIColor = Constants.lightColor2 {
        didSet {
            outerCircle.colors[1] = color2
            middleCircle.colors[0] = color2
            innerCircle.colors[0] = color2
        }
    }
    var color3: UIColor = Constants.lightColor3 {
        didSet { middleCircle.colors[1] = color3 }
    }
    var color4: UIColor = Constants.lightColor4 {
        didSet { innerCircle.colors[1] = color4 }
    }

    var highlightColor: UIColor = .white {
        didSet {
            outerCircleStroke.colors[1] = highlightColor
        }
    }

    var onColor: UIColor = Constants.dotBlueColor {
        didSet {
            glowCircleLayer.colors = [onColor, onColor.withAlphaComponent(0.7)]
        }
    }



    var shadowOpacity: Float = 0.4 {
        didSet {
            middleCircleShadow.shadowOpacity = shadowOpacity
        }
    }

    var outerCircleMultiplier: CGFloat = Constants.outerMultiplier {
        didSet {
            guard innerCircleMultiplier < middleCircleMultiplier && middleCircleMultiplier < outerCircleMultiplier else {
                fatalError("Values should be: innerCircleMultiplier < middleCircleMultiplier < outerCircleMultiplier.")
            }
            outerCircleStroke.multiplier = outerCircleMultiplier
            outerCircle.multiplier = outerCircleMultiplier
        }
    }
    var middleCircleMultiplier: CGFloat = Constants.middleMultiplier {
        didSet {
            guard innerCircleMultiplier < middleCircleMultiplier && middleCircleMultiplier < outerCircleMultiplier else {
                fatalError("Values should be: innerCircleMultiplier < middleCircleMultiplier < outerCircleMultiplier.")
            }
            middleCircle.multiplier = middleCircleMultiplier
            glowCircleLayer.multiplier = middleCircleMultiplier
            middleCircleShadow.path = layer.circlePath(with: middleCircleMultiplier).cgPath
        }
    }
    var innerCircleMultiplier: CGFloat = Constants.innerMultiplier {
        didSet {
            guard innerCircleMultiplier < middleCircleMultiplier && middleCircleMultiplier < outerCircleMultiplier else {
                fatalError("Values should be: innerCircleMultiplier < middleCircleMultiplier < outerCircleMultiplier.")
            }
            innerCircle.multiplier = innerCircleMultiplier
        }
    }

    // MARK: - Private Properties

    private let backgroundLayer: CircularLayer = {
        let layer = CircularLayer(colors: [.black, .clear], maskType: .fill)
        layer.gradientType = .radial
        layer.locations = [0, 0.45]
        layer.opacity = 0.5
        return layer
    }()

    lazy private var outerCircleStroke: CircularLayer = {
        let layer = CircularLayer(colors: [color1, highlightColor], maskType: .stroke(width: 1.2))
        layer.locations = [0.0, 0.4]
        layer.multiplier = outerCircleMultiplier
        return layer
    }()

    lazy private var outerCircle: CircularLayer = {
        let layer = CircularLayer(colors: [color1, color2], maskType: .fill)
        layer.multiplier = outerCircleMultiplier
        return layer
    }()

    lazy private var glowCircleLayer: CircularLayer = {
        let layer = CircularLayer(colors: [onColor, onColor], maskType: .stroke(width: 5))
        layer.multiplier = middleCircleMultiplier
        return layer
    }()

    lazy private var middleCircleShadow: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.setShadow(color: .black, opacity: shadowOpacity, offset: CGSize(width: 2, height: 11), radius: 6)
        layer.fillColor = Constants.lightColor3.cgColor
        return layer
    }()

    lazy private var middleCircle: CircularLayer = {
        let layer = CircularLayer(colors: [color2, color3], maskType: .fill)
        layer.multiplier = middleCircleMultiplier
        return layer
    }()

    lazy private var innerCircle: CircularLayer = {
        let layer = CircularLayer(colors: [color2, color4], maskType: .fill)
        layer.gradientType = .linear(direction: .topLeftToBottomRight)
        layer.multiplier = innerCircleMultiplier
        return layer
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        backgroundLayer.frame = bounds
        outerCircleStroke.frame = bounds
        outerCircle.frame = bounds
        middleCircle.frame = bounds
        innerCircle.frame = bounds

        middleCircleShadow.path = layer.circlePath(with: middleCircleMultiplier).cgPath
        glowCircleLayer.frame = bounds

    }

    private func commonInit() {
        backgroundColor = .clear

        layer.addSublayer(backgroundLayer)
        layer.insertSublayer(outerCircleStroke, above: backgroundLayer)
        layer.insertSublayer(outerCircle, above: outerCircleStroke)

        layer.insertSublayer(glowCircleLayer, above: outerCircle)
        layer.insertSublayer(middleCircleShadow, above: glowCircleLayer)
        layer.insertSublayer(middleCircle, above: middleCircleShadow)

        layer.insertSublayer(innerCircle, above: middleCircle)
    }

}
