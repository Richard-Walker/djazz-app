//
//  Router.swift
//  djazz
//
//  Created by Richard Walker on 28/02/15.
//  Copyright (c) 2015 Bright Moods Studios. All rights reserved.
//

import Foundation
import AlamoFire

// An enum to encapsulate the server endpoints
enum Router {
    case Root
    case Events
    case Event(String)
    case Rooms
    case LightThings(room: String)
    case LightThing(room: String, thing: String)
    
    var url: String {
        
        let baseURLString = "http://192.168.0.5:5000"
        
        let path: String = {
            switch self {
            case .Root:
                return "/"
            case .Events:
                return "/events"
            case .Event(let event):
                return "/events/\(event)"
            case .Rooms:
                return "/rooms"
            case .LightThings(let room):
                return "/rooms/\(room)"
            case .LightThing(let room, let thing):
                return "/rooms/\(room)/light-things/\(thing)"
            }
        }()
 
        return baseURLString + path
    }
}
