//
//  EventsTableCell.swift
//  djazz
//
//  Created by Richard Walker on 15/02/15.
//  Copyright (c) 2015 Bright Moods Studio. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var toggle: UISwitch!
    
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
    
    
    func updateCellContent(event: DZEvent) {
        
        let timeFormatter = NSDateFormatter()
        timeFormatter.locale = NSLocale(localeIdentifier: "fr_FR")
        timeFormatter.dateStyle = .NoStyle
        timeFormatter.timeStyle = .ShortStyle
        
        nameLabel.text = event.name
        timeLabel.text = timeFormatter.stringFromDate(event.time)
        progressView.progress = 0
        toggle.on = event.enabled
        
/*        if indexPath.row == 0 {
            cell.eventProgressView.progress = 0.6
            cell.eventEditButton.hidden = true
            cell.eventSwitch.hidden = true
            cell.eventStopButton.hidden = false
        }
*/
        
        self.updateCellStatus(self)
    }
    
    @IBAction func updateCellStatus(sender: AnyObject) {
        if toggle.on {
            self.backgroundColor = backgroundColorWhenActive
            timeLabel.textColor = nil
            nameLabel.textColor = nil
        } else {
            self.backgroundColor = nil
            timeLabel.textColor = UIColor.grayColor()
            nameLabel.textColor = UIColor.grayColor()
        }
    }

}
