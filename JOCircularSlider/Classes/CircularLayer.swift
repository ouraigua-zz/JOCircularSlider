//
//  CircularLayer.swift
//  JOCircularSlider
//
//  Created by Jalal Ouraigua on 04/12/2018.
//  Copyright © 2018 Jalal Ouraigua. All rights reserved.
//

import UIKit

public enum CircleMaskType {
    case stroke(width: CGFloat)
    case fill
}

public enum GradientType {
    case linear(direction: GradientDirection)
    case radial
}

public enum GradientDirection: Int {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
    case topLeftToBottomRight
    case topRightToBottomLeft
    case bottomLeftToTopRight
    case bottomRightToTopLeft

    func coordinates(for rect: CGRect) -> (start: CGPoint, end: CGPoint) {
        switch self {
        case .leftToRight:           return (CGPoint(x: 0, y: 0), CGPoint(x: rect.width, y: 0))
        case .rightToLeft:           return (CGPoint(x: rect.width, y: 0), CGPoint(x: 0, y: 0))
        case .topToBottom:           return (CGPoint(x: 0, y: 0), CGPoint(x: 0, y: rect.height))
        case .bottomToTop:           return (CGPoint(x: 0, y: rect.height), CGPoint(x: 0, y: 0))
        case .topLeftToBottomRight:  return (CGPoint(x: 0, y: 0), CGPoint(x: rect.width, y: rect.height))
        case .topRightToBottomLeft:  return (CGPoint(x: rect.width, y: 0), CGPoint(x: 0, y: rect.height))
        case .bottomLeftToTopRight:  return (CGPoint(x: 0, y: rect.height), CGPoint(x: rect.width, y: 0))
        case .bottomRightToTopLeft:  return (CGPoint(x: rect.width, y: rect.height), CGPoint(x: 0, y: 0))
        }
    }
}

class CircularLayer: CALayer {

    // MARK: - Public Properties

    var gradientType: GradientType = .linear(direction: .topToBottom) {
        didSet { setNeedsDisplay() }
    }
    var locations: [CGFloat] = [0.0, 1.0] {
        didSet { setNeedsDisplay() }
    }
    var colors: [UIColor] = [.red, .blue] {
        didSet { setNeedsDisplay() }
    }
    var maskType: CircleMaskType = .fill {
        didSet { setNeedsDisplay() }
    }
    var multiplier: CGFloat = 1.0 {
        didSet { setNeedsDisplay() }
    }

    // MARK: - Private Properties

    fileprivate let maskLayer = CAShapeLayer()

    private var center: CGPoint {
        return CGPoint(x: bounds.width/2, y: bounds.height/2)
    }
    private var radius: CGFloat {
        return (bounds.width + bounds.height)/2
    }
    private var cgColors: [CGColor] {
        return colors.map {$0.cgColor}
    }

    // MARK: - Init

    init(gradientType: GradientType = .linear(direction: .topToBottom),
         colors: [UIColor],
         maskType: CircleMaskType,
         locations: [CGFloat] = [0.0, 1.0],
         multiplier: CGFloat = 1.0) {

        self.gradientType = gradientType
        self.colors = colors
        self.maskType = maskType
        self.locations = locations
        self.multiplier = multiplier

        super.init()
        needsDisplayOnBoundsChange = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init()
        needsDisplayOnBoundsChange = true
    }

    override init(layer: Any) {
        super.init(layer: layer)
        needsDisplayOnBoundsChange = true
    }

    override func draw(in ctx: CGContext) {

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations) else { return }

        switch gradientType {
        case .radial:
            ctx.drawRadialGradient(gradient, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions(rawValue: 0))
        case .linear(let direction):
            let coordinates = direction.coordinates(for: bounds)
            ctx.drawLinearGradient(gradient, start: coordinates.start, end: coordinates.end, options: CGGradientDrawingOptions(rawValue: 0))
        }

        switch maskType {
        case .fill: break
        case .stroke(let width):
            maskLayer.fillColor = UIColor.clear.cgColor
            maskLayer.lineWidth = width
            maskLayer.strokeColor = UIColor.black.cgColor
        }

        maskLayer.path = circlePath(with: multiplier).cgPath
        self.mask = maskLayer
    }
}
