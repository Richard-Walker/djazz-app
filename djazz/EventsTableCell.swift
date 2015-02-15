//
//  EventsTableCell.swift
//  djazz
//
//  Created by Richard Walker on 15/02/15.
//  Copyright (c) 2015 Bright Moods Studios. All rights reserved.
//

import UIKit

class EventsTableCell: UITableViewCell {
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventProgressView: UIProgressView!
    @IBOutlet weak var eventActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var eventEditButton: UIButton!
    @IBOutlet weak var eventStopButton: UIButton!
    @IBOutlet weak var eventSwitch: UISwitch!
    
    var test: Int = 5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
