//
//  Light.swift
//  djazz
//
//  Created by Richard Walker on 30/03/15.
//  Copyright (c) 2015 Bright Moods Studios. All rights reserved.
//

import Foundation
import Alamofire

class Light {
    
    // MARK: - properties
    
    var level: Int = 0 // Value from 0 to 100
    var room: String = ""
    var name: String = ""
    
    // MARK: - initialiser
    
    init(room: String, name: String) {
        self.room = room
        self.name = name
    }

    
    // MARK: - methods that gets stuff from djazz server
    
    // loads light level from server
    func load(callback: (()->())? = nil, errorCallback: (()->())? = nil) {
        
        
        self.level = 10
        
        /*
        Alamofire.request(.GET, Router.Events.url).validate().responseJSON() {
            (_, _, data, error) in
            
            if error == nil {
                for json in JSON(data!)["_items"].arrayValue {
                    // We cannot use subscripts directly in the event initializer because of a bug in xcode (complie error)
                    let id = json["_id"].stringValue
                    let name = json["name"].stringValue
                    let enabled = json["enabled"].boolValue
                    let time = NSDate.parse(json["time"].stringValue)!
                    let title = json["title"].stringValue
                    var e = Event(id, name, enabled, time, title, delegate: self.delegate)
                    self.append(e)
                }
                callback?()
                
            } else {
                self.delegate?.networkErrorOccurred("Could not load events.", error: error!)
                errorCallback?()
            }
        }
        */
        
    }

    
    
}