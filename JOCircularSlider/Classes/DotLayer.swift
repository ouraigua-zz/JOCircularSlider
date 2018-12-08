//
//  DotLayer.swift
//  JOCircularSlider
//
//  Created by Jalal Ouraigua on 04/12/2018.
//  Copyright © 2018 Jalal Ouraigua. All rights reserved.
//

import UIKit

class DotLayer: CALayer {


    var color = Constants.dotGrayColor {
        didSet {
            gradientLayer.colors = [shadowColor ?? color.cgColor, color.cgColor]
            frontLayer.fillColor = color.cgColor
        }
    }
    var shadowMultiplier: CGFloat = 0.1


    override var shadowColor: CGColor? {
        get { return gradientLayer.colors?.first as! CGColor? }
        set {
            gradientLayer.colors = [newValue ?? color.cgColor, color.cgColor]
        }
    }

    var highlightColor: UIColor? = .white

    private let backLayer = CAShapeLayer()
    private let frontLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()
    private let maskLayer = CAShapeLayer()

    init(color: UIColor,
         shadowColor: UIColor? = UIColor.darkGray.withAlphaComponent(0.5),
         shadowMultiplier: CGFloat) {

        self.color = color
        self.shadowMultiplier = shadowMultiplier

        super.init()
        needsDisplayOnBoundsChange = true
        setupSublayers()
        self.shadowColor = shadowColor?.cgColor
    }

    override init(layer: Any) {
        super.init(layer: layer)
        setupSublayers()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSublayers()
    }

    private func setupSublayers() {

        backLayer.fillColor = color.cgColor
        frontLayer.fillColor = color.cgColor

        maskLayer.fillColor = nil
        maskLayer.strokeColor = color.cgColor

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.locations = [0, 1]

        addSublayer(backLayer)
        addSublayer(frontLayer)
        addSublayer(maskLayer)
        addSublayer(gradientLayer)

        gradientLayer.mask = maskLayer
    }

    override func layoutSublayers() {
        super.layoutSublayers()

        let path = UIBezierPath(ovalIn: bounds).cgPath
        let offset = CGSize(width: bounds.width * shadowMultiplier, height: bounds.height * shadowMultiplier)

        backLayer.path = path
        //backLayer.setShadow(color: highlightColor, opacity: 1, offset: CGSize(width: offset.width/2, height: offset.height), radius: 0)
        backLayer.setShadow(color: highlightColor, opacity: 1, offset: CGSize(width: offset.width, height: offset.height), radius: 0)

        frontLayer.path = path

        maskLayer.lineWidth = offset.width
        maskLayer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: offset.width/2, dy: offset.height/2)).cgPath


        gradientLayer.frame = bounds

    }
}
