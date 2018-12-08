//
//  DotView.swift
//  JOCircularSlider
//
//  Created by Jalal Ouraigua on 04/12/2018.
//  Copyright © 2018 Jalal Ouraigua. All rights reserved.
//

import UIKit

class DotView: UIView {

    enum DotType {
        case mini
        case maxi
    }

    // MARK: - Properties

    var type: DotType = .maxi
    var isClockwise = true { didSet { reload() }}
    var startAngle: CGFloat = (.pi/4.0)*3.0
    var endAngle: CGFloat = .pi/4.0
    var dotCountPerSegment: Int = 6
    var outerCircleRadius: CGFloat? { didSet { reload() }}

    lazy var maxDotCount: Int = {
        return Int(Float(maxiDotCount) / 5.0) + (maxiDotCount % 5 == 0 ? 0 : 1)
    }()

    lazy var dotInset: CGFloat = {
        return type == .mini ? 10.0 : 15.0
    }()

    lazy var maxiDotCount: Int = {
        return Int(angleRange / (.pi*2.0 / 15.0))
    }()

    lazy var dotRadiusMultiplier: CGFloat =  type == .mini ? 0.22 : 0.09

    // Colors

    var offColor: UIColor = Constants.dotGrayColor {
        didSet { reload() }
    }

    var onColor: UIColor = Constants.dotBlueColor {
        didSet { reload() }
    }

    var maxColor: UIColor = Constants.dotRedColor {
        didSet { reload() }
    }

    var highlightColor: UIColor? = .white {
        didSet { reload() }
    }

    private var currentIndex: Int = 0
    private var value: Float = 0

    // MARK: - Init

    init(type: DotType, startAngle: CGFloat, endAngle: CGFloat, isClockwise: Bool) {
        self.type = type
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.isClockwise = isClockwise

        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let sublayers = layer.sublayers else { return }

        let radius = outerCircleRadius == nil ? (bounds.width/2) - dotRadius - dotInset : outerCircleRadius! + dotRadius + dotInset

        for i in 0..<sublayers.count {
            guard let dotLayer = sublayers[i] as? DotLayer else { continue }
            if type == .mini && (i % dotCountPerSegment == 0) {
                continue
            }
            let angle = startAngle + ((CGFloat(i) * unitAngle) * (isClockwise ? 1 : -1))
            dotLayer.frame = CGRect(x: cos(angle) * radius - dotRadius,
                                    y: sin(angle) * radius - dotRadius,
                                    width: dotRadius * 2,
                                    height: dotRadius * 2)
        }
        currentIndex = -1
        updateColors(using: value)
    }

    func reload() {
        layer.sublayers?.removeAll()
        commonInit()
    }

    func updateColors(using value: Float) {
        guard type == .maxi else { return }
        let index = Int(value * Float(dotCount - 1))
        guard index != currentIndex else { return }
        currentIndex = index
        self.value = value
        guard let sublayers = layer.sublayers else { return }
        var hue: CGFloat = 0; var saturation: CGFloat = 0 ; var brightness: CGFloat = 0
        onColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
        var j: CGFloat = 0
        for i in 0..<sublayers.count {
            guard let dotLayer = sublayers[i] as? DotLayer else { continue }
            guard i <= currentIndex else { dotLayer.color = offColor; continue }
            guard i >= dotCount - maxDotCount else { dotLayer.color = onColor; continue }
            let newHue = hue > 0.5 ? hue + (j * ((1.0 - hue)/CGFloat(maxDotCount-1))) : hue - (j * (hue/CGFloat(maxDotCount-1)))
            dotLayer.color = UIColor(hue: newHue , saturation: saturation, brightness: brightness, alpha: 1)
            j += 1.0
        }
    }
}

// MARK: Private API

private extension DotView {

    var dotCount: Int {
        switch type {
        case .mini: return (maxiDotCount - 1) * (dotCountPerSegment) + 1
        case .maxi: return maxiDotCount
        }
    }

    var dotRadius: CGFloat {
        let opposite = sin(unitAngle) * (bounds.width/2)
        return opposite/2 * dotRadiusMultiplier
    }

    var angleRange: CGFloat {
        return angleDifferenceInDegree(from: startAngle.toDegree, to: endAngle.toDegree, isClockwise: isClockwise).toRadian
    }

    var unitAngle: CGFloat {
        switch type {
        case .mini: return (angleRange / CGFloat(maxiDotCount - 1)) / CGFloat(dotCountPerSegment)
        case .maxi: return angleRange / CGFloat(dotCount - 1)
        }
    }

    func commonInit() {
        for _ in 0..<dotCount {
            var dotLayer: DotLayer
            switch type {
            case .mini: dotLayer = DotLayer(color: offColor, shadowMultiplier: 0.18)
            case .maxi: dotLayer = DotLayer(color: offColor, shadowMultiplier: 0.1)
            }
            dotLayer.highlightColor = highlightColor
            layer.addSublayer(dotLayer)
        }
    }
}
