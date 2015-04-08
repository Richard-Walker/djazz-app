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
    var id: String?
    
    
    // MARK: - initialiser
    
    init(room: String, name: String, netDelegates: NetworkDelegates? = nil) {
        self.room = room
        self.name = name
        self.netDelegates = netDelegates
    }

    
    // MARK: - methods that gets stuff from djazz server
    
    // loads light level and id from server
    func load(callback: (()->())? = nil, errorCallback: (()->())? = nil) {
        
        let filter =  "{\"room\":\"\(room)\",\"name\":\"\(name)\"}"
        
        Networking.request(.GET, url: Router.Things.url, parameters: ["where":filter]) {
            (data, error) in
            
            if error == nil {
                let jsonItems = JSON(data!)["_items"].arrayValue
                
                if jsonItems.count == 0 {
                    self.netDelegates?.networkErrorOccurred("Thing '\(self.name)' not found on server.", error: nil)
                    errorCallback?()
                    
                } else {
                    let json = jsonItems[0]
                    // We cannot use subscripts directly in the event initializer because of a bug in xcode (complie error)
                    self.id = json["_id"].stringValue
                    self.level = json["state"]["level"].intValue

                    callback?()
                
                }
            } else {
                self.netDelegates?.networkErrorOccurred("Could not load light thing.", error: error!)
                errorCallback?()
            }
            
        }
        
    }
    
    
    // MARK: - methods that modify the state of a thing on djazz server
    
    
    func updateLevel(newLevel: Int, callback: (()->())? = nil, errorCallback: (()->())? = nil) {
        
        let updates = [ "state" : [ "level" : newLevel ] ]
        
        Networking.request(.PATCH, url: Router.Thing(self.id!).url, parameters: updates) {
            (data, error) in
            
            if error == nil {
                self.level = newLevel
                callback?()
            } else {
                self.netDelegates?.networkErrorOccurred("Could not update light level.", error: error!)
                errorCallback?()
            }
        }
        
    }

    
//    func updateLevel(newLevel: Int, callback: (()->())? = nil, errorCallback: (()->())? = nil) {
//        
//        let updates = [ "state" : [ "level" : newLevel ] ]
//        
//        Alamofire.request(.PATCH, Router.Thing(self.id!).url, parameters: updates, encoding: .JSON).validate().responseJSON() {
//            (_, _, data, error) in
//            
//            if error == nil {
//                self.level = newLevel
//                callback?()
//            } else {
//                self.netDelegates?.networkErrorOccurred("Could not update light level.", error: error!)
//                errorCallback?()
//            }
//        }
//
//    }

    

    
    
}