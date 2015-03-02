//
//  EditEventViewController.swift
//  djazz
//
//  Created by Richard Walker on 16/02/15.
//  Copyright (c) 2015 Bright Moods Studios. All rights reserved.
//

import UIKit

class EditEventViewController: UIViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    var chosenTime: String?
    var eventCell: EventCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let time = NSDate.dateFromTime(eventCell?.timeLabelButton.titleLabel?.text)
        if time != nil { datePicker.date = time! }
        eventNameLabel?.text = eventCell?.nameLabel.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if sender as UIBarButtonItem == saveButton {
            chosenTime = self.datePicker.date.timePart
        }
    }

}
