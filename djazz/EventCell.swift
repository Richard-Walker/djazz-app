//
//  EventsTableCell.swift
//  djazz
//
//  Created by Richard Walker on 15/02/15.
//  Copyright (c) 2015 Bright Moods Studio. All rights reserved.
//

import UIKit

protocol EventCellDelegates {
    func eventActivated(cell: EventCell)
    func eventDeactivated(cell: EventCell)
}

class EventCell: UITableViewCell {
    @IBOutlet weak var timeLabelButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var toggle: UISwitch!
    
    var rowIndex : Int = 0
    
    var deleguate: EventCellDelegates?
    
    var backgroundColorWhenActive: UIColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColorWhenActive = self.backgroundColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var active: Bool {
        get {
            return toggle.on
        }
        set(value) {
            if value == true {
                self.backgroundColor = backgroundColorWhenActive
                //timeLabelButton.titleLabel?.textColor = nil
                timeLabelButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
                nameLabel.textColor = nil
                toggle.on = true
            } else {
                self.backgroundColor = nil
                timeLabelButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
                nameLabel.textColor = UIColor.grayColor()
                toggle.on = false
            }
        }
    }
    
    @IBAction func updateCellStatus(sender: AnyObject) {
        
        if toggle.on == true {
            deleguate?.eventActivated(self)
        } else {
            deleguate?.eventDeactivated(self)
        }
    }

}
