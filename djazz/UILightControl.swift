//
//  LightUIControl.swift
//  djazz
//
//  Created by Richard Walker on 01/04/15.
//  Copyright (c) 2015 Bright Moods Studios. All rights reserved.
//

import Foundation

import UIKit

protocol UILightControlDelegates {
    func userChangedLightLevel(uiControl: UILightControl )
}


class UILightControl {
    
    var timer: NSTimer?
    let timerTimeInterval: Double = 0.5
    
    var label: UILabel
    var slider: UISlider
    var stepper: UIStepper
    var delegates: UILightControlDelegates?
    
    var level : Int {
        get {
            return Int(stepper.value)
        }
        set {
            slider.setValue(Float(newValue), animated: true)
            stepper.value = round(Double(newValue) / stepper.stepValue) * stepper.stepValue
            
            if stepper.value == 0 {
                label.text = String(format: format, "OFF")
            } else {
                label.text = String(format: format, "\(Int(stepper.value))%")
            }
        }
    }
    
    /// value chosen by the user with the control
    var userLevel : Int? {
        didSet {
            if userLevel != oldValue {
                delegates?.userChangedLightLevel(self)
            }
        }
    }
    
    var enabled : Bool {
        get {
            return stepper.enabled
        }
        set {
            stepper.enabled = newValue
            slider.enabled = newValue
            if newValue == true {
                (stepper.alpha, slider.alpha) = (1,1)
            } else {
                (stepper.alpha, slider.alpha) = (0.3,0.3)
            }
        }
    }
    
    var format : String
    
    init(label: UILabel, slider: UISlider, stepper: UIStepper, delegates: UILightControlDelegates?=nil) {
        self.label = label
        self.slider = slider
        self.stepper = stepper
        self.format = label.text!
        
        self.delegates = delegates
        
        level = Int(stepper.value)
        
        self.enabled = false
        
        slider.addTarget(self, action: "sliderValueChanged", forControlEvents: .ValueChanged)
        stepper.addTarget(self, action: "stepperValueChanged", forControlEvents: .ValueChanged)
        
        slider.addTarget(self, action: "sliderTouchedUp", forControlEvents: .TouchUpInside | .TouchUpOutside)
        stepper.addTarget(self, action: "stepperTouchedUp", forControlEvents: .TouchUpInside | .TouchUpOutside)
        
    }
    
    @objc
    func sliderValueChanged() {
        level = Int(round(slider.value))
    }
    
    @objc
    func stepperValueChanged() {
        //let step = stepper.stepValue
        //level = Int(round(stepper.value / step) * step)
        level = Int(stepper.value)
    }

    @objc
    func sliderTouchedUp() {
        userLevel = level
    }
    
    @objc
    func stepperTouchedUp() {
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(timerTimeInterval, target: self, selector: "timerFired", userInfo: nil, repeats: false)
    }
    
    @objc
    func timerFired() {
        userLevel = level
    }

}
