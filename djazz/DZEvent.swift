//
//  DZEvent.swift
//  djazz
//
//  Created by Richard Walker on 16/02/15.
//  Copyright (c) 2015 Bright Moods Studios. All rights reserved.
//

import Foundation

class DZEvent {
    var name = "new event"
    var time = NSDate()
    var enabled = false
    var duration = NSTimeInterval(5)
    init(name: String) {
        self.name = name
    }
}
