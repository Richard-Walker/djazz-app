//
//  Light.swift
//  djazz
//
//  Created by Richard Walker on 30/03/15.
//  Copyright (c) 2015 Bright Moods Studios. All rights reserved.
//

import Foundation
import Alamofire


class LightThing {
    
    // MARK: - properties
    
    var level: Int = 0 // Value from 0 to 100
    var room: String = ""
    var name: String = ""
    var netDelegates : NetworkDelegates?
    
    
    // MARK: - initialiser
    
    init(room: String, name: String, netDelegates: NetworkDelegates? = nil) {
        self.room = room
        self.name = name
        self.netDelegates = netDelegates
    }

    
    // MARK: - methods that gets stuff from djazz server
    
    // loads light level from server
    func load(callback: (()->())? = nil, errorCallback: (()->())? = nil) {
        
        self.level = 10
        callback?()
        
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
    
    
    // MARK: - methods that modify an event instance and sync it on djazz server
    
    func updateLevel(newLevel: Int, callback: (()->())? = nil, errorCallback: (()->())? = nil) {
        
        self.level = newLevel;
        callback?()

        
/*        Alamofire.request(.PATCH, Router.Event(self.id).url, parameters: updates.jsonSafe, encoding: .JSON).validate().responseJSON() {
            (_, _, data, error) in
            
            if error == nil {
                for (key,value) in updates {
                    self.setValue(value, forKey: key)
                }
                callback?()
                
                
            } else {
                self.delegate?.networkErrorOccurred("Could not update event.", error: error!)
                errorCallback?()
            }
        }
*/
    }


    
    
}