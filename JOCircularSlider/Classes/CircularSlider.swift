//
//  CircularSlider.swift
//  JOCircularSlider
//
//  Created by Jalal Ouraigua on 04/12/2018.
//  Copyright © 2018 Jalal Ouraigua. All rights reserved.
//

import UIKit

public struct Constants {

    public static let lightTextColor = UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1)
    public static let darkTextColor = UIColor.black
    public static let fontName = "HelveticaNeue-Light"   // HelveticaNeue-Light  Helvetica-Bold

    public static let lightColor1 = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 0.2)
    public static let lightColor2 = UIColor(red: 249/255.0, green: 249/255.0, blue: 249/255.0, alpha: 1)
    public static let lightColor3 = UIColor(red: 173/255.0, green: 174/255.0, blue: 175/255.0, alpha: 1)
    public static let lightColor4 = UIColor(red: 206/255.0, green: 206/255.0, blue: 206/255.0, alpha: 1)

    public static let darkColor1 = UIColor.black
    public static let darkColor2 = UIColor(red: 39/255.0, green: 46/255.0, blue: 56/255.0, alpha: 1)
    public static let darkColor3 = UIColor.black
    public static let darkColor4 = UIColor(red: 34/255.0, green: 37/255.0, blue: 44/255.0, alpha: 1)

    public static let lightHighlightColor = UIColor.white
    public static let darkHighlightColor = UIColor(red: 86/255.0, green: 93/255.0, blue: 108/255.0, alpha: 1)


    public static let dotBlueColor = UIColor(red: 31/255.0, green: 206/255.0, blue: 252/255.0, alpha: 1)
    public static let dotRedColor = UIColor(red: 248/255.0, green: 16/255.0, blue: 32/255.0, alpha: 1)
    public static let dotOrangeColor = UIColor(red: 1, green: 128/255.0, blue: 0, alpha: 1)
    public static let dotGrayColor = lightColor4
    public static let dotShadowOffset = CGSize(width: 2, height: 2)

    public static let outerMultiplier  : CGFloat = 0.86
    public static let middleMultiplier : CGFloat = 0.7
    public static let innerMultiplier  : CGFloat = 0.54
}

@IBDesignable
open class CircularSlider: UIControl {

    // MARK: - Public API

    @IBInspectable open var color1: UIColor {
        get { return renderer.knobView.color1 }
        set { renderer.knobView.color1 = newValue }
    }

    @IBInspectable open var color2: UIColor {
        get { return renderer.knobView.color2 }
        set { renderer.knobView.color2 = newValue}
    }

    @IBInspectable open var color3: UIColor {
        get { return renderer.knobView.color3 }
        set { renderer.knobView.color3 = newValue}
    }

    @IBInspectable open var color4: UIColor {
        get { return renderer.knobView.color4 }
        set {
            renderer.knobView.color4 = newValue
            renderer.pointerView.color1 = newValue
        }
    }

    @IBInspectable open var highlightColor: UIColor {
        get { return renderer.knobView.highlightColor }
        set {
            renderer.knobView.highlightColor = newValue
            renderer.maxiDotView.highlightColor = newValue
            renderer.miniDotView.highlightColor = newValue
            renderer.textField.layer.shadowColor = newValue.cgColor
            renderer.setTextShadow(color: newValue, opacity: 1, offset: CGSize(width: 0.5, height: 0.5), radius: 0)
        }
    }

    @IBInspectable open var knobOuterCircleMultiplier: CGFloat {
        get { return renderer.knobView.outerCircleMultiplier }
        set {
            renderer.knobView.outerCircleMultiplier = newValue
            renderer.miniDotView.outerCircleRadius = (bounds.width/2 * newValue)
            renderer.maxiDotView.outerCircleRadius = (bounds.width/2 * newValue)
        }
    }

    @IBInspectable open var knobMiddleCircleMultiplier: CGFloat {
        get { return renderer.knobView.middleCircleMultiplier }
        set {
            renderer.knobView.middleCircleMultiplier = newValue
        }
    }

    @IBInspectable open var knobInnerCircleMultiplier: CGFloat {
        get { return renderer.knobView.innerCircleMultiplier }
        set { renderer.knobView.innerCircleMultiplier = newValue }
    }

    @IBInspectable open var knobShadowOpacity: Float {
        get { return renderer.knobView.shadowOpacity }
        set { renderer.knobView.shadowOpacity = newValue }
    }

    @IBInspectable open var pointerDistanceFromInnerCircleEdge: CGFloat {
        get { return renderer.pointerViewDistanceFromEdge }
        set { renderer.pointerViewDistanceFromEdge = newValue }
    }

    @IBInspectable open var pointerSizeMultiplier: CGFloat {
        get { return renderer.pointerViewMultiplier }
        set { renderer.pointerViewMultiplier = newValue }
    }

    @IBInspectable open var pointerColor1: UIColor {
        get { return renderer.pointerView.color1 }
        set { renderer.pointerView.color1 = newValue }
    }

    @IBInspectable open var pointerColor2: UIColor {
        get { return renderer.pointerView.color2 }
        set { renderer.pointerView.color2 = newValue }
    }

    @IBInspectable open var textIsHidden: Bool {
        get { return renderer.textFieldIsHidden }
        set { renderer.textFieldIsHidden = newValue}
    }

    @IBInspectable open var textFontSizeMultiplier: CGFloat {
        get { return renderer.fontSizeMultiplier }
        set { renderer.fontSizeMultiplier = newValue}
    }

    @IBInspectable open var textColor: UIColor {
        get { return renderer.textField.textColor! }
        set { renderer.textField.textColor = newValue}
    }

    @IBInspectable open var maxidotViewIsHidden: Bool {
        get { return renderer.maxiDotView.isHidden }
        set { renderer.maxiDotView.isHidden = newValue }
    }

    @IBInspectable open var maxidotOffColor: UIColor {
        get { return renderer.maxiDotView.offColor }
        set { renderer.maxiDotView.offColor = newValue }
    }

    @IBInspectable open var maxidotOnColor: UIColor {
        get { return renderer.maxiDotView.onColor }
        set {
            renderer.maxiDotView.onColor = newValue
            renderer.knobView.onColor = newValue
            //renderer.pointerView.color1 = newValue
        }
    }

    @IBInspectable open var maxidotMaxColor: UIColor {
        get { return renderer.maxiDotView.maxColor }
        set { renderer.maxiDotView.maxColor = newValue }
    }

    @IBInspectable open var maxidotCount: Int {
        get { return renderer.maxiDotView.maxiDotCount }
        set {
            let value = newValue % 2 == 0 ? newValue + 1 : newValue
            renderer.maxiDotView.maxiDotCount = value
            renderer.maxiDotView.reload()
            renderer.miniDotView.maxiDotCount = value
            renderer.miniDotView.reload()
        }
    }

    @IBInspectable open var maxidotRadiusMultiplier: CGFloat {
        get { return renderer.maxiDotView.dotRadiusMultiplier }
        set { renderer.maxiDotView.dotRadiusMultiplier = newValue }
    }

    @IBInspectable open var maxidotInset: CGFloat {
        get { return renderer.maxiDotView.dotInset }
        set { renderer.maxiDotView.dotInset = newValue }
    }

    @IBInspectable open var maxidotMaxDotCount: Int {
        get { return renderer.maxiDotView.maxDotCount }
        set { renderer.maxiDotView.maxDotCount = newValue }
    }

    @IBInspectable open var minidotViewIsHidden: Bool {
        get { return renderer.miniDotView.isHidden }
        set { renderer.miniDotView.isHidden = newValue }
    }

    @IBInspectable open var minidotColor: UIColor {
        get { return renderer.miniDotView.offColor }
        set { renderer.miniDotView.offColor = newValue }
    }

    @IBInspectable open var minidotHighlightColor: UIColor {
        get { return renderer.miniDotView.highlightColor ?? .white }
        set { renderer.miniDotView.highlightColor = newValue }
    }

    @IBInspectable open var minidotCountPerSegment: Int {
        get { return renderer.miniDotView.dotCountPerSegment }
        set {
            renderer.miniDotView.dotCountPerSegment = newValue
            renderer.miniDotView.reload()
        }
    }

    @IBInspectable open var minidotRadiusMultiplier: CGFloat {
        get { return renderer.miniDotView.dotRadiusMultiplier }
        set { renderer.miniDotView.dotRadiusMultiplier = newValue }
    }

    @IBInspectable open var minidotInset: CGFloat {
        get { return renderer.miniDotView.dotInset }
        set { renderer.miniDotView.dotInset = newValue }
    }

    @IBInspectable open var minidotHideHighlight: Bool {
        get { return renderer.miniDotView.highlightColor != nil }
        set { renderer.miniDotView.highlightColor = newValue ? highlightColor : nil }
    }

    /**
        This value will be pinned to minimumValue/maximumValue
        The default value of this property is 0.0.
    */
    @IBInspectable open var value: CGFloat {        // always min <= value <= max
        get { return CGFloat(renderer.value) * (maximumValue - minimumValue) + minimumValue }
        set {
            guard maximumValue >= minimumValue else {
                fatalError("`maximumValue` should be greater then `minimumValue`.")
            }
            let rangedValue = min(maximumValue, max(minimumValue, newValue))
            renderer.value = Float((rangedValue - minimumValue) / (maximumValue - minimumValue))
        }
    }

    @IBInspectable open var minimumValue: CGFloat = 0

    @IBInspectable open var maximumValue: CGFloat = 100

    @IBInspectable open var startAngle: CGFloat {
        get { return renderer.startAngle.toDegree }
        set { renderer.startAngle = newValue.toRadian }
    }

    @IBInspectable open var endAngle: CGFloat {
        get { return renderer.endAngle.toDegree }
        set { renderer.endAngle = newValue.toRadian }
    }

    @IBInspectable open var isClockwise: Bool {
        get { return renderer.isClockwise }
        set { renderer.isClockwise = newValue }
    }

    @IBInspectable open var labelDecimalPlaces: Int = 0

    // MARK: - Private Properties

    lazy private var renderer = Renderer(with: self)
    private var lastTouchAngle: CGFloat = 0
    private var centerPoint: CGPoint { return CGPoint(x: bounds.midX, y: bounds.midY) }

    // MARK: - Functions

    override public init(frame: CGRect) {
        super.init(frame: frame)
        value = minimumValue
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        value = minimumValue
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        renderer.updateUI(in: bounds)
    }

    // MARK: - Touches

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let location = touches.first?.location(in: self) else { return }

        let distanceToOrigin = location - centerPoint
        lastTouchAngle = atan2(distanceToOrigin.y, distanceToOrigin.x).toDegree
        sendActions(for: .editingDidBegin)
    }

    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let location = touches.first?.location(in: self) else { return }

        let distanceToOrigin = location - centerPoint
        let currentTouchAngle = atan2(distanceToOrigin.y, distanceToOrigin.x).toDegree

        let angelDelta = currentTouchAngle - lastTouchAngle // in degree
        lastTouchAngle = currentTouchAngle

        let angleRange = angleDifferenceInDegree(from: startAngle, to: endAngle, isClockwise: isClockwise)

        let angelDeltaAsPercentage = Float(angelDelta / angleRange)
        guard abs(angelDeltaAsPercentage) < 1 else { return }
        let newValue = renderer.value + (isClockwise ? angelDeltaAsPercentage : -angelDeltaAsPercentage)
        renderer.value = max(0, min(newValue, 1))

    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        sendActions(for: .editingDidEnd)
    }
    
    // MARK: - Public

    open func setLabelFont(named: String, textColor: UIColor, multiplier: CGFloat) {
        textFontSizeMultiplier = multiplier
        let textSize = bounds.height * multiplier
        renderer.setTextFont(named: named, textColor: textColor, textSize: textSize)
    }

    open func setLabelShadow(color: UIColor, opacity: Float = 1, offset: CGSize = CGSize(width: 1, height: 1), radius: CGFloat = 0) {
        renderer.setTextShadow(color: color, opacity: opacity, offset: offset, radius: radius)
    }

    open func setLabelText(_ text: String?) {
        renderer.textField.text = text
    }

}

class Renderer {

    // MARK: - Properties

    weak var circularSlider: CircularSlider?

    fileprivate let knobView = KnobView(frame: .zero)
    fileprivate let pointerView = PointerView(frame: .zero)
    fileprivate let textField = UITextField()
    fileprivate var miniDotView: DotView!
    fileprivate var maxiDotView: DotView!

    fileprivate var isClockwise: Bool = true {
        didSet {
            miniDotView.isClockwise = isClockwise
            maxiDotView.isClockwise = isClockwise
        }
    }
    fileprivate var textFieldIsHidden: Bool = false
    fileprivate var fontSizeMultiplier: CGFloat = 0.5

    fileprivate var pointerViewDistanceFromEdge: CGFloat = 10.0
    fileprivate var pointerViewMultiplier: CGFloat = 0.15

    fileprivate var startAngle: CGFloat = (.pi/4.0)*3.0 {
        didSet {
            miniDotView.startAngle = startAngle
            maxiDotView.startAngle = startAngle
        }
    }

    fileprivate var endAngle: CGFloat = .pi/4.0 {
        didSet {
            miniDotView.endAngle = endAngle
            maxiDotView.endAngle = endAngle
        }
    }

    fileprivate var value: Float = 0.0 {      // 0 <= renderer.value <= 1
        didSet {
            // updates
            updateText()
            if let bounds = circularSlider?.bounds {
                updatePointerView(in: bounds)
            }
            maxiDotView.updateColors(using: value)

            circularSlider?.sendActions(for: .valueChanged)
        }
    }

    // MARK: - Init

    init(with view: CircularSlider) {
        self.circularSlider = view
        commonInit()
    }

    func updateUI(in bounds: CGRect) {
        updatePointerView(in: bounds)
        updateTextField(in: bounds)
        updateDotViews(in: bounds)
    }

    func setTextFont(named: String, textColor: UIColor, textSize: CGFloat) {
        textField.textColor = textColor
        textField.font = UIFont(name: named, size: textSize) ?? UIFont.systemFont(ofSize: textSize)
    }

    func setTextShadow(color: UIColor, opacity: Float = 1, offset: CGSize = CGSize(width: 1, height: 1), radius: CGFloat = 0) {
        textField.layer.setShadow(color: color, opacity: opacity, offset: offset, radius: radius)
    }
}

// MARK: - Private API

private extension Renderer {

    func commonInit() {
        addKnobView()
        addDotViews()
        addPointerView()
        addTextField()
    }

    func addKnobView() {
        circularSlider?.addSubview(knobView)
        knobView.translatesAutoresizingMaskIntoConstraints = false
        let views = ["view": knobView]
        let verticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: .init(rawValue: 0), metrics: nil, views: views)
        let horizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: .init(rawValue: 0), metrics: nil, views: views)
        circularSlider?.addConstraints(verticalConstraint + horizontalConstraint)
    }

    func addPointerView() {
        circularSlider?.addSubview(pointerView)
    }

    func addInputAccessoryView() {
        let width = UIScreen.main.bounds.width
        let toolBar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: width, height: 48)))
        toolBar.barStyle = .blackTranslucent
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(keyboardDoneButtonTapped))
        done.tintColor = .lightGray
        toolBar.items = [done, flexibleSpace]
        toolBar.sizeToFit()
        textField.inputAccessoryView = toolBar
    }

    func addTextField() {
        textField.backgroundColor = .clear
        textField.layer.cornerRadius = 3
        textField.textAlignment = .center
        textField.text = ""
        textField.keyboardType = .numbersAndPunctuation
        textField.keyboardAppearance = .dark
        textField.clearsOnInsertion = true
        textField.adjustsFontSizeToFitWidth = true
        if let height = circularSlider?.bounds.height {
            setTextFont(named: Constants.fontName, textColor: Constants.lightTextColor, textSize: height * fontSizeMultiplier)
        }
        setTextShadow(color: .white)

        addInputAccessoryView()
        circularSlider?.addSubview(textField)
    }

    func addDotViews() {
        miniDotView = DotView(type: .mini, startAngle: startAngle, endAngle: endAngle, isClockwise: isClockwise)
        circularSlider?.addSubview(miniDotView)

        maxiDotView = DotView(type: .maxi, startAngle: startAngle, endAngle: endAngle, isClockwise: isClockwise)
        circularSlider?.addSubview(maxiDotView)
    }

    @objc func keyboardDoneButtonTapped() {
        textField.endEditing(true)
        guard let text = textField.text, let newValue = Int(text) else {
            updateText()
            return
        }
        circularSlider?.value = CGFloat(newValue)
        circularSlider?.sendActions(for: .editingDidEnd)

        //maxiDotView.setNeedsLayout()
    }

    // MARK: - Updates

    func updateDotViews(in bounds: CGRect) {
        let dotViewFrame = CGRect(origin: CGPoint(x: bounds.midX, y: bounds.midY), size: bounds.size)
        miniDotView.frame = dotViewFrame
        maxiDotView.frame = dotViewFrame
        let outerCircleRadius = bounds.width/2 * knobView.outerCircleMultiplier
        miniDotView.outerCircleRadius = outerCircleRadius
        maxiDotView.outerCircleRadius = outerCircleRadius
    }

    func updateTextField(in bounds: CGRect) {

        let multiplier: CGFloat = max(0.1, min(0.5, fontSizeMultiplier/2))

        let width = (bounds.width * knobView.innerCircleMultiplier) * 0.8
        let height = (bounds.height * knobView.innerCircleMultiplier) * multiplier
        let x = (bounds.width - width)/2
        let y = (bounds.height - height)/2
        textField.frame = CGRect(x: x, y: y, width: width, height: height)

        let name = textField.font?.fontName ?? Constants.fontName
        textField.font = UIFont(name: name, size: textField.frame.height)

        textField.isHidden = textFieldIsHidden
    }

    func updateText() {
        guard let circularSlider = circularSlider else { return }

        let minimum = Float(circularSlider.minimumValue)
        let maximum = Float(circularSlider.maximumValue)
        let _value = Float(circularSlider.value)

        var decimalPlaces = circularSlider.labelDecimalPlaces
        if value != 0 && _value.rounded(.towardZero) == 0 && decimalPlaces == 0 {
            decimalPlaces = 2
        }

        let newValue = _value.roundedDown(toPlaces: decimalPlaces)

        switch newValue {
        case minimum: textField.text = "MIN"
        case maximum: textField.text = "MAX"
        default: textField.text = String(format: "%.\(decimalPlaces)f", newValue)
        }
    }

    func updatePointerView(in bounds: CGRect) {

        let angleRange = angleDifferenceInDegree(from: startAngle.toDegree, to: endAngle.toDegree, isClockwise: isClockwise)
        let angle = isClockwise ? startAngle.toDegree + (angleRange * CGFloat(value)) : startAngle.toDegree - (angleRange * CGFloat(value))

        let radius = (bounds.width * knobView.innerCircleMultiplier)/2
        let width = radius * pointerViewMultiplier

        let adjustX = bounds.midX - width/2
        let adjustY = bounds.midY - width/2

        let x = cos(angle.toRadian) * (radius - pointerViewDistanceFromEdge - width/2) + adjustX
        let y = sin(angle.toRadian) * (radius - pointerViewDistanceFromEdge - width/2) + adjustY

        pointerView.frame = CGRect(x: x, y: y, width: width, height: width)

    }

}
