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
    
    var url: String {
        let baseURLString = "http://192.168.0.5:5000"
        
        let path: String = {
            switch self {
            case .Root:
                return "/"
            case .Events:
                return "/events"
            case .Event(let eventName):
                return "/events/\(eventName)"
            }
        }()
 
        return baseURLString + path
    }
}
