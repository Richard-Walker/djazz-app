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
import Alamofire



// MARK: - Protocols -----------------------------------------------------------------------

protocol EventDelegates {
    func eventHapenned(event: Event)
}



// MARK: - Class Event -----------------------------------------------------------------------

class Event: NSObject {
    
    // MARK: - properties
    
    // FIXME: align server interface to these names
    var delegate : EventDelegates?
    var netDelegates : NetworkDelegates?
    var index: Int?
    var id: String
    var name: String
    var enabled: Bool { didSet { resetTimer() } }
    var time: NSDate { didSet { resetTimer() } }
    var title: String
    var timer: NSTimer = NSTimer()
    
    // MARK: - initialiser
    
    init(_ id: NSString, _ name: String, _ enabled: Bool=false, _ time: NSDate=NSDate(), _ title: String="",
        delegate: EventDelegates?=nil, netDelegates: NetworkDelegates? = nil) {
        
            self.id = id
            self.name = name
            self.enabled = enabled
            self.time = time
            self.title = title
            self.delegate = delegate
    }
    
    // MARK: - methods that modify an event instance and sync it on djazz server
    
    func update(updates: [String:AnyObject], callback: (()->())? = nil, errorCallback: (()->())? = nil) {
        
        Networking.request(.PATCH, url: Router.Event(self.id).url, parameters: updates.jsonSafe) {
            (data, error) in
            
            if error == nil {
                for (key,value) in updates {
                    self.setValue(value, forKey: key)
                }
                callback?()
                

            } else {
                self.netDelegates?.networkErrorOccurred("Could not update event.", error: error!)
                errorCallback?()
            }
        }

    }
    
    // MARK: - timer methods
    
    func resetTimer() {
        timer.invalidate()
        if self.enabled {
            timer = NSTimer(fireDate: time, interval: 0, target: self, selector: Selector("timerFired:"), userInfo: nil, repeats: false)
            NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
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
    
    var delegates: EventDelegates?
    var netDelegates : NetworkDelegates?
    var eventList: [Event] = []

    // MARK: - initialiser

    init(delegates: EventDelegates? = nil, netDelegates: NetworkDelegates? = nil) {
        self.delegates = delegates
        self.netDelegates = netDelegates
    }

    // MARK: - event list accessors & manipulators
    
    subscript(index:Int) -> Event { return eventList[index] }
    subscript(id:String) -> Event? { return eventList.find { $0.id == id } }
    var count: Int { return eventList.count }
    var countEnabled: Int { return eventList.filter({(e) in e.enabled}).count }
    func append(event: Event) { event.index = self.count; eventList.append(event) }


    // MARK: - methods that gets stuff from djazz server
    
    // loads event list from server
    func load(callback: (()->())? = nil, errorCallback: (()->())? = nil) {
        
        Networking.request(.GET, url: Router.Events.url, parameters: nil) {
            (data, error) in
            
            if error == nil {
                for json in JSON(data!)["_items"].arrayValue {
                    // We cannot use subscripts directly in the event initializer because of a bug in xcode (complie error)
                    let id = json["_id"].stringValue
                    let name = json["name"].stringValue
                    let enabled = json["enabled"].boolValue
                    let time = NSDate.parse(json["time"].stringValue)!
                    let title = json["title"].stringValue
                    var e = Event(id, name, enabled, time, title, delegate: self.delegates, netDelegates: self.netDelegates)
                    self.append(e)
                }
                callback?()

            } else {
                self.netDelegates?.networkErrorOccurred("Could not load events.", error: error!)
                errorCallback?()
            }
        }

    }
    
}
