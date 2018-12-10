//
//  ViewController.swift
//  JOCircularSlider
//
//  Created by Jalal Ouraigua on 12/05/2018.
//  Copyright (c) 2018 Jalal Ouraigua. All rights reserved.
//

import UIKit
import JOCircularSlider

class ViewController: UIViewController {

    @IBOutlet weak var circularSlider: CircularSlider! {
        didSet {
            circularSlider.addTarget(self, action: #selector(handleValueChanged(_:)), for: .valueChanged)
        }
    }
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint! {
        didSet {
            let isPad = UIScreen.main.traitCollection.userInterfaceIdiom == .pad
            widthConstraint.constant = isPad ? -100.0 : 0
        }
    }

    private var theme: Theme = .dark

    @IBAction private func toggleTheme(_ sender: UISegmentedControl) {
        guard let theme = Theme(rawValue: sender.selectedSegmentIndex) else { return }
        self.theme = theme

        if let gradientView = view as? GradientView {
            gradientView.color1 = theme.gradientViewColor1
            gradientView.color2 = theme.gradientViewColor2
        }

        circularSlider.color1 = theme.color1
        circularSlider.color2 = theme.color2
        circularSlider.color3 = theme.color3
        circularSlider.color4 = theme.color4
        circularSlider.highlightColor = theme.highlightColor
        circularSlider.maxidotOnColor = theme.onColor
        circularSlider.maxidotOffColor = theme.maxidotOffColor
        circularSlider.textColor = theme.textColor
        circularSlider.pointerColor1 = theme.pointerColor1
        circularSlider.pointerColor2 = theme.pointerColor2
        circularSlider.knobShadowOpacity = theme.shadowOpacity
        circularSlider.minidotColor = theme.minidotColor
        circularSlider.minidotHighlightColor = theme.minidotHighlightColor

        // change controls tinit color
        let darkColor = UIColor(red: 86/255.0, green: 93/255.0, blue: 108/255.0, alpha: 1)
        let lightColor = UIColor(red: 136/255.0, green: 143/255.0, blue: 160/255.0, alpha: 1)
        let sliderDark = UIColor(red: 52/255.0, green: 60/255.0, blue: 72/255.0, alpha: 1)
        let sliderLight = UIColor(red: 128/255.0, green: 136/255.0, blue: 149/255.0, alpha: 1)

        for subview in stackView.subviews {

            if let slider = subview as? UISlider {
                slider.tintColor = theme == .dark ? sliderDark : sliderLight
                slider.maximumTrackTintColor = theme == .dark ? .black : UIColor.white.withAlphaComponent(0.4)

            } else {
                subview.tintColor = theme == .dark ? darkColor : lightColor
            }
        }
    }

    @IBAction private func toggleDirection(_ sender: UISegmentedControl) {

        guard let direction = Direction(rawValue: sender.selectedSegmentIndex) else { return }

        circularSlider.isClockwise = direction == .clockwise
        circularSlider.startAngle = direction.startAngle
        circularSlider.endAngle = direction.endAngle
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.circularSlider.setValue(self.circularSlider.value, isPercentage: true)
        }
    }

    @IBAction private func toggleMiniView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            circularSlider.minidotViewIsHidden = false
            circularSlider.maxidotCount = 10
            circularSlider.maxidotMaxDotCount = 3
            circularSlider.maxidotRadiusMultiplier = 0.09
            circularSlider.minidotColor = theme.minidotColor
        } else {
            circularSlider.minidotViewIsHidden = true
            circularSlider.maxidotCount = 40
            circularSlider.maxidotMaxDotCount = 10
            circularSlider.maxidotRadiusMultiplier = 0.25
        }
    }

    @IBAction private func changeRadius(_ sender: UISlider) {
        let newMultiplier = CGFloat(sender.value)
        if sender.tag == 2 {
            guard newMultiplier < circularSlider.knobMiddleCircleMultiplier else { return }
            circularSlider.knobInnerCircleMultiplier = newMultiplier
        } else if sender.tag == 0 {
            guard newMultiplier > circularSlider.knobMiddleCircleMultiplier else { return }
            circularSlider.knobOuterCircleMultiplier = min(0.99, newMultiplier)
        } else {
            guard newMultiplier < circularSlider.knobOuterCircleMultiplier &&
                newMultiplier > circularSlider.knobInnerCircleMultiplier else { return }
            circularSlider.knobMiddleCircleMultiplier = newMultiplier
        }

        circularSlider.setValue(circularSlider.value, isPercentage: true)

    }

    @IBAction private func changeDotCount(_ sender: UISlider) {
        circularSlider.maxidotCount = Int(sender.value)
        circularSlider.maxidotMaxDotCount = Int(sender.value / 5.0)
    }

    @IBAction private func changeColor(_ sender: UISlider) {
        circularSlider.maxidotOnColor = UIColor(hue: CGFloat(sender.value), saturation: 1, brightness: 1, alpha: 1)
    }

    @IBAction func handleValueChanged(_ sender: CircularSlider) {
        print(sender.value)
    }

    
}

