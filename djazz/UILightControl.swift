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
    
    var label: UILabel
    var slider: UISlider
    var stepper: UIStepper
    var delegates: UILightControlDelegates?
    
    
    var level : Int {
        get {
            return Int(stepper.value)
        }
        set {
            stepper.value = Double(newValue)
            slider.setValue(Float(newValue), animated: true)
            
            if newValue == 0 {
                label.text = String(format: format, "OFF")
            } else {
                label.text = String(format: format, "\(newValue)%")
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
    
    var format : String
    
    init(label: UILabel, slider: UISlider, stepper: UIStepper, delegates: UILightControlDelegates?=nil) {
        self.label = label
        self.slider = slider
        self.stepper = stepper
        self.format = label.text!
        
        self.delegates = delegates
        
        level = Int(stepper.value)
        
        slider.addTarget(self, action: "sliderValueChanged", forControlEvents: .ValueChanged)
        stepper.addTarget(self, action: "stepperValueChanged", forControlEvents: .ValueChanged)
        
        slider.addTarget(self, action: "touchedUp", forControlEvents: .TouchUpInside | .TouchUpOutside)
        stepper.addTarget(self, action: "touchedUp", forControlEvents: .TouchUpInside | .TouchUpOutside)

    }
    
    @objc
    func sliderValueChanged() {
        level = Int(round(slider.value))
    }
    
    @objc
    func stepperValueChanged() {
        level = Int(stepper.value)
    }

    @objc
    func touchedUp() {
        userLevel = level
    }
}
