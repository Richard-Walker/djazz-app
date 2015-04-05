//
//  BedroomLightsController.swift
//  djazz
//
//  Created by Richard Walker on 06/04/15.
//  Copyright (c) 2015 Bright Moods Studios. All rights reserved.
//

import UIKit

class BedroomLightsController: UIViewController, UILightControlDelegates, NetworkDelegates {
    
    
    // MARK: - Properties -------------------------------------------------------------------
    
    /// The model of this view: lights things of the living room
    var roomLightThing = LightThing(room: "bedroom", name: "mainlights")
    
    @IBOutlet weak var roomLightLabel: UILabel!
    @IBOutlet weak var roomLightSlider: UISlider!
    @IBOutlet weak var roomLightStepper: UIStepper!
    
    var roomLightControl: UILightControl!
    
    // MARK: - View load -------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        roomLightControl = UILightControl(label: roomLightLabel, slider: roomLightSlider, stepper: roomLightStepper, delegates: self)
        
        roomLightThing.netDelegates = self
        
        roomLightThing.load {
            self.roomLightControl.level = self.roomLightThing.level
        }
        
    }

    // MARK: - Protocol NetworkDelegates -------------------------------------------------
    
    func networkErrorOccurred(message:String, error: NSError?) {
        // A network error has occurred, we display a popup in the current view to inform the user
        self.error(error, message: message)
    }

    
    // MARK: - Protocol LightUIControlDeleguates -------------------------------------------------
    
    func userChangedLightLevel(uiControl: UILightControl) {
        if uiControl === roomLightControl {
            roomLightThing.updateLevel(uiControl.level)
        }
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
