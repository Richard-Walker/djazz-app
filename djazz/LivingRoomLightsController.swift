//
//  LivingRoomLightsController.swift
//  djazz
//
//  Created by Richard Walker on 30/03/15.
//  Copyright (c) 2015 Bright Moods Studios. All rights reserved.
//

import UIKit


// TODO: Rename LivingRoomLightsController -> LivingRoomLightsViewController
class LivingRoomLightsController: UIViewController, UILightControlDelegates {

    // MARK: - Properties -------------------------------------------------------------------
    
    /// The model of this view: lights things of the living room
    var roomLightThing = LightThing(room: "livingroom", name: "room")
    var moonsLightThing = LightThing(room: "livingroom", name: "moons")
    
    
    @IBOutlet weak var roomLightLabel: UILabel!
    @IBOutlet weak var roomLightSlider: UISlider!
    @IBOutlet weak var roomLightStepper: UIStepper!
    
    @IBOutlet weak var moonsLightLabel: UILabel!
    @IBOutlet weak var moonsLightSlider: UISlider!
    @IBOutlet weak var moonsLightStepper: UIStepper!
    
    var roomLightControl: UILightControl!
    var moonsLightControl : UILightControl!

    // MARK: - View load -------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        roomLightControl = UILightControl(label: roomLightLabel, slider: roomLightSlider, stepper: roomLightStepper, delegates: self)
        moonsLightControl = UILightControl(label: moonsLightLabel, slider: moonsLightSlider, stepper: moonsLightStepper, delegates: self)
        
        roomLightThing.load()
        moonsLightThing.load()
        
    }

    
    // MARK: - Protocol LightUIControlDeleguates -------------------------------------------------

    func userChangedLightLevel(uiControl: UILightControl) {
        
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
