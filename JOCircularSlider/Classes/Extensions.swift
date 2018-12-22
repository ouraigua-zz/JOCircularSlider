//
//  Extensions.swift
//  JOCircularSlider
//
//  Created by Jalal Ouraigua on 04/12/2018.
//  Copyright © 2018 Jalal Ouraigua. All rights reserved.
//

import UIKit

public func angleDifferenceInDegree(from start: CGFloat, to end: CGFloat, isClockwise: Bool) -> CGFloat {
    if isClockwise {
        return start >= end ? 360 - (start - end) : end - start
    } else {
        return start >= end ? start - end : 360 - (end - start)
    }
}

extension FloatingPoint {

    public var toRadian: Self { return self * .pi / 180 }

    public var toDegree: Self {
        let degree = self * 180 / .pi
        return degree >= 0 ? degree : 360 + degree
    }

    public func roundedDown(toPlaces places: Int) -> Self {
        let rounded = self.rounded(.down)
        let power = Self(Int(powf(10, Float(places))))
        let decimal = ((self - rounded) * power).rounded(.down)
        return rounded + (decimal / power)
    }
}

extension CGPoint {

    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.y,
                       y: lhs.y + rhs.y)
    }

    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.y,
                       y: lhs.y - rhs.y)
    }
}

extension CALayer {

    func setShadow(color: UIColor?, opacity: Float = 1, offset: CGSize = CGSize(width: 1, height: 1), radius: CGFloat = 0) {
        self.shadowColor = color?.cgColor
        self.shadowOpacity = opacity
        self.shadowOffset = offset
        self.shadowRadius = radius
    }

    func circlePath(with multiplier: CGFloat) -> UIBezierPath {
        let multiplier = (1 - max(0, min(multiplier, 1))) / 2.0
        return UIBezierPath(ovalIn: bounds.insetBy(dx: bounds.width * multiplier, dy: bounds.height * multiplier))
    }
}
