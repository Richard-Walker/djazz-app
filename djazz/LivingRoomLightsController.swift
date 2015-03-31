//
//  LivingRoomLightsController.swift
//  djazz
//
//  Created by Richard Walker on 30/03/15.
//  Copyright (c) 2015 Bright Moods Studios. All rights reserved.
//

import UIKit

class LightControl {
    
    var label: UILabel
    var slider: UISlider
    var stepper: UIStepper
    
    var level : Int {
        return Int(round(slider.value))
    }
    
    var format : String
    
    init(label: UILabel, slider: UISlider, stepper: UIStepper) {
        self.label = label
        self.slider = slider
        self.stepper = stepper
        self.format = label.text!
        updateLabel()
        
        slider.addTarget(self, action: "sliderValueChanged", forControlEvents: .ValueChanged)
        stepper.addTarget(self, action: "stepperValueChanged", forControlEvents: .ValueChanged)
    }
    
    @objc
    func sliderValueChanged() {
        stepper.value = Double(slider.value)
        updateLabel()
    }

    @objc
    func stepperValueChanged() {
        slider.setValue(Float(stepper.value), animated: true)
        updateLabel()
    }
    
    func updateLabel() {
        label.text = String(format: format, level)
    }
}

class LivingRoomLightsController: UIViewController {

    // MARK: - Properties -------------------------------------------------------------------
    
    /// The model of this view: lights things of the living room
    var roomLight = Light(room: "livingroom", name: "room")
    var moonsLight = Light(room: "livingroom", name: "moons")
    
    
    @IBOutlet weak var roomLightLabel: UILabel!
    @IBOutlet weak var roomLightSlider: UISlider!
    @IBOutlet weak var roomLightStepper: UIStepper!
    
    @IBOutlet weak var moonsLightLabel: UILabel!
    @IBOutlet weak var moonsLightSlider: UISlider!
    @IBOutlet weak var moonsLightStepper: UIStepper!
    
    var roomLightControl: LightControl!
    var moonsLightControl : LightControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomLightControl = LightControl(label: roomLightLabel, slider: roomLightSlider, stepper: roomLightStepper)
        moonsLightControl = LightControl(label: moonsLightLabel, slider: moonsLightSlider, stepper: moonsLightStepper)
        
        // Do any additional setup after loading the view.
        
        roomLight.load()
        moonsLight.load()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
