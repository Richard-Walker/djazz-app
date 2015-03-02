//
//  Events.swift
//  djazz
//
//  Created by Richard Walker on 02/03/15.
//  Copyright (c) 2015 Bright Moods Studios. All rights reserved.
//
//  This is the file that defines the events model
//

import Foundation
import AlamoFire



// MARK: - Protocols -----------------------------------------------------------------------

protocol EventsModelDelegate {
    func eventHapenned(event: Event)
    func networkErrorOccurred(message:String, error: NSError)
}



// MARK: - Class Event -----------------------------------------------------------------------

class Event: NSObject {
    
    // MARK: - properties
    
    // FIXME: align server interface to these names
    var delegate : EventsModelDelegate?
    var index: Int?
    var id: String
    var name: String
    var enabled: Bool { didSet { resetTimer() } }
    var time: NSDate { didSet { resetTimer() } }
    var title: String
    var timer: NSTimer = NSTimer()
    
    // MARK: - initialiser
    
    init(_ id: NSString, _ name: String, _ enabled: Bool=false, _ time: NSDate=NSDate(), _ title: String="", delegate: EventsModelDelegate?=nil) {
        self.id = id
        self.name = name
        self.enabled = enabled
        self.time = time
        self.title = title
        self.delegate = delegate
    }
    
    // MARK: - methods that modify an event instance and sync it on djazz server
    
    func update(updates: [String:AnyObject], callback: (()->())? = nil, errorCallback: (()->())? = nil) {
        
        Alamofire.request(.PATCH, Router.Event(self.id).url, parameters: updates.jsonSafe, encoding: .JSON).validate().responseJSON() {
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

    }
    
    // MARK: - timer methods
    
    func resetTimer() {
        timer.invalidate()
        if self.enabled {
            timer = NSTimer(fireDate: time, interval: 0, target: self, selector: Selector("timerFired:"), userInfo: nil, repeats: false)
            NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        }
    }
    
    func timerFired(timer: NSTimer) {
        enabled = false
        delegate?.eventHapenned(self)
    }
    
}



// MARK: - Class Events -----------------------------------------------------------------------

class Events {
    
    // MARK: - properties
    
    var delegate: EventsModelDelegate?
    var eventList: [Event] = []

    // MARK: - initialiser

    init(delegate: EventsModelDelegate? = nil) {
        self.delegate = delegate
    }

    // MARK: - event list accessors & manipulators
    
    subscript(index:Int) -> Event { return eventList[index] }
    subscript(id:String) -> Event? { return eventList.find { $0.id == id } }
    var count: Int { return eventList.count }
    func append(event: Event) { event.index = self.count; eventList.append(event) }


    // MARK: - methods that gets stuff from djazz server
    
    // loads event list from server
    func load(callback: (()->())? = nil, errorCallback: (()->())? = nil) {
        
        Alamofire.request(.GET, Router.Events.url).validate().responseJSON() {
            (_, _, data, error) in
            
            if error == nil {
                for json in JSON(data!)["_items"].arrayValue {
                    // We cannot use subscripts directly in the event initializer because of a bug in xcode (complie error)
                    let id = json["_id"].stringValue
                    let name = json["id"].stringValue
                    let enabled = json["enabled"].boolValue
                    let time = NSDate.parse(json["time"].stringValue)!
                    let title = json["name"].stringValue
                    var e = Event(id, name, enabled, time, title, delegate: self.delegate)
                    self.append(e)
                }
                callback?()

            } else {
                self.delegate?.networkErrorOccurred("Could not load events.", error: error!)
                errorCallback?()
            }
        }

    }
    
}
